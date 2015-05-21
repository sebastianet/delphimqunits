unit mq_basicC ;

//
// Operacions basiques amb el MQ des Delphi
//
//	v 1.0	inici : copia de mq_basic.c (v 1.7) i canvi de MQIS per MQIC.
// compte : MQCONN ( @ qmn, @ hCon, @ cc, @ rc ) no te sentit amb llibreries "client" .... MQCONNX ?
//  v 1.10 - use AnsiString ans AnsyChar ;
//

interface

uses
  Windows, StdCtrls, SysUtils, MQIC, SAG_debug ;

const

  kVersio = 'v 1.10' ;
  kData_Darrera_Modificacio = '20150520' ;  

function  GetEnvironmentVariableAsString ( const VarName: string ) : string ;

function  ConnectMQ    ( tLB : TListBox; QMgrName : AnsiString ) : THandle ;
procedure DisconnectMQ ( tLB : TListBox; hCon : THandle ) ;

function  MQ_Open_Queue  ( tLB : TListBox; hCon : THandle; Queue_Name : AnsiString ; od : MQOD ; oo : integer ) : THandle ;
procedure MQ_Close_Queue ( tLB : TListBox; hCon, hObj : THandle ) ;

function  MQ_TryToRcv_Msg ( tLB : TListBox; hCon, hObj : THandle ; ptr_md : PMQMD ; gmo : MQGMO ; buflen : integer ; Ptr_Buffer : PChar ; pCC : PMQLONG ; pRC : PMQLONG ) : integer ;
function  MQ_Empty_Rcv_Q  ( tLB : TListBox; hCon, hObj : THandle ) : integer ;
procedure MQ_Send_Msg     ( tLB : TListBox; hCon, hObj : THandle ; ptr_md : PMQMD ; pmo : MQPMO ; msglen : integer ; Ptr_Buffer : PChar ) ;

implementation

// ****************************************************

function GetEnvironmentVariableAsString ( const VarName: string ) : string ;
var bsz: Integer ;
begin

  // Get required buffer size (inc. terminal #0)
  bsz := GetEnvironmentVariable ( PChar ( VarName ), nil, 0 ) ;

  if ( bsz > 0 ) then begin

    // Read env var value into result string
    SetLength ( Result, bsz - 1 ) ;
    GetEnvironmentVariable ( PChar(VarName), PChar(Result), bsz ) ;

  end else // No such environment variable
    Result := '' ;
end ;   // get Envir Var

// ****************************************************

function ConnectMQ ( tLB : TListBox; QMgrName : AnsiString ) : THandle ;
var
  hCon   : THandle ;
  qmn    : MQCHAR48 ;
  cc, rc : integer ;
  szOut  : string ;

begin

     strpcopy ( qmn, QMgrName ) ;
     MQCONN ( @ qmn, @ hCon, @ cc, @ rc ) ;

     if ( cc = MQCC_FAILED ) then begin
          hCon := 0 ;
     end ;

     szOut := '{' + kVersio + '} MQCONN() {' + qmn + '}. Handle {'+IntToStr(hCon)+'}. CC/RC {' + IntToStr(cc) +'/'+ IntToStr(rc) + '}.' ;
     SAGdebugMsg ( tLB, szOut ) ;

//		case cc of
//
//			MQCC_WARNING : begin
//				szOut := '1, Warning' ;
//			end ; // 1, warning
//
//			MQCC_FAILED : begin
//				szOut := '2, Failed' ;
//			end ; // 2, failed
//
//		end ; // case

    result := hCon ;

end ; // connect()

// ******************************************************************************

procedure DisconnectMQ ( tLB : TListBox; hCon : THandle ) ;
var
  cc, rc : integer ;
  szOut  : string ;
  hOld   : THandle ;

begin

  hOld := hCon ; // just to trace it
  MQDISC ( @ hCon, @ cc, @ rc ) ;
  szOut := 'MQDISC('+IntToStr(hOld)+'). CC/RC {' + IntToStr(cc) +'/'+ IntToStr(rc) + '}.' ;
  SAGdebugMsg ( tLB, szOut ) ;
  hCon := 0 ; // no fa res, pero ens recorda de fer-ho a l'altre banda ...
  
end ; // disc()

// ******************************************************************************

function MQ_Open_Queue ( tLB : TListBox; hCon : THandle; Queue_Name : AnsiString ; od : MQOD ; oo : integer ) : THandle ;
var
  cc, rc : integer ;
  hObj  : THandle ;
  szOut : string ;  
	
begin

  strpcopy( od.ObjectName, copy( Queue_Name, 1, sizeof(od.ObjectName)-1) ) ;
  
  MQOPEN ( hCon, @od, oo, @hObj, @cc, @rc ) ;

  if ( cc = MQCC_FAILED ) then begin
    hObj := 0 ;
  end ;
  
  szOut := 'MQOPEN()  Object{' + od.ObjectName + '}. oType['+IntToStr(od.ObjectType)+']. oOptions['+IntToStr(oo)+']. Handle {'+IntToStr(hObj)+'}. CC/RC {' + IntToStr(cc) +'/'+ IntToStr(rc) + '}.' ;
  SAGdebugMsg ( tLB, szOut ) ;
     
  result := hObj ;
  
end ; // open()

// ******************************************************************************

procedure MQ_Close_Queue ( tLB : TListBox; hCon, hObj : THandle ) ;
var
  cc, rc : integer ;
  szOut  : string ;
  hOld   : THandle ;

begin

  hOld := hObj ; // just to trace it
  MQCLOSE ( hCon, @ hObj, 0, @ cc, @ rc);
  szOut := 'MQCLOSE('+IntToStr(hOld)+'). CC/RC {' + IntToStr(cc) +'/'+ IntToStr(rc) + '}.' ;
  SAGdebugMsg ( tLB, szOut ) ;
  hObj := 0 ; // recordar de fer-ho a l'altre banda ...

end ; // close()

// ******************************************************************************

function MQ_TryToRcv_Msg ( tLB : TListBox; hCon, hObj : THandle ; ptr_md : PMQMD ; gmo : MQGMO ; buflen : integer ; Ptr_Buffer : PChar ; pCC : PMQLONG ; pRC : PMQLONG ) : integer ;
var
  msglen : integer ;
//	cc, rc : integer ;
  szOut  : string ;

begin

// MQGET sets Encoding and CodedCharSetId to the values in the message returned,
// so these fields should be reset to the default values before every call,
// in case MQGMO_CONVERT is specified.

  ptr_md^.Encoding       := MQENC_NATIVE ;
  ptr_md^.CodedCharSetId := MQCCSI_Q_MGR ;

  msglen := 0 ;

  MQGET ( hCon,              // in : connection handle
          hObj,              // in : object handle
          ptr_md,            // in/out : message descriptor
        @ gmo,               // in/out : get message options
          buflen,            // in : buffer length
          Ptr_Buffer,        // out : message buffer
        @ msglen,            // out : message length
//        @ cc,                // out : completion code
          pCC,
//        @ rc ) ;             // out : reason code
          pRC ) ; 

  if ( tLB <> nil ) then begin
    szOut := 'MQGET() end. hCon('+IntToStr(hCon)+'), hObj('+IntToStr(hObj)+'). CC/RC {' + IntToStr(pCC^) +'/'+ IntToStr(pRC^) + '}.' ;
    SAGdebugMsg ( tLB, szOut ) ;
  end ;

  result := msglen ;
  
end ; // get()

// ******************************************************************************

function MQ_Empty_Rcv_Q ( tLB : TListBox; hCon, hObj : THandle ) : integer ;
var
  iCC, iRC : integer ;
  cnt : integer ;
  szOut : string ;
  
  md_Rcv : MQMD ;
  gmo : MQGMO ;
  msglen : integer ;

begin

	cnt := 0 ;
	repeat

  	move( MQMD_DEFAULT, md_Rcv, sizeof(MQMD_DEFAULT) ) ;		// init message descriptor
    move( MQGMO_DEFAULT, gmo, sizeof(MQGMO_DEFAULT) ) ;     // init get message options
  	gmo.Options := MQGMO_NO_WAIT + MQGMO_ACCEPT_TRUNCATED_MSG ;			// set Get Msg Options

  	szOut := 'MQEMPTY() start.' ;
  	SAGdebugMsg ( tLB, szOut ) ;
	
  	MQGET ( hCon,              // in : queue manager connection handle
    	      hObj,              // in : queue object handle
      	  @ md_Rcv,            // in/out : message descriptor
        	@ gmo,               // in/out : get message options
	          0,                 // in : buffer length
  	        nil,               // out : message buffer
    	    @ msglen,            // out : message length
      	  @ iCC,
        	@ iRC ) ; 

		if not ( ( iCC=02 ) and ( iRC=2033 ) ) then
			cnt := cnt + 1 ;

  	szOut := 'MQ_empty() result. CC/RC {' + IntToStr(iCC) +'/'+ IntToStr(iRC) + '}.' ;
  	SAGdebugMsg ( tLB, szOut ) ;
		
	until ( ( iCC=02 ) and ( iRC=2033 ) ) ;
	
  result := cnt ;
  
end ; // empty()


// ******************************************************************************

procedure MQ_Send_Msg ( tLB : TListBox; hCon, hObj : THandle ; ptr_md : PMQMD ; pmo : MQPMO ; msglen : integer ; Ptr_Buffer : PChar ) ;
var
  cc, rc : integer ;
  szOut : string ;

begin

	move( MQPMO_DEFAULT, pmo, sizeof( MQPMO_DEFAULT ) ) ;
	
	MQPUT ( hCon,				// in : connection handle
	        hObj,				// in : object handle
	        ptr_md,			// in/out : message descriptor
	      @ pmo,				// in/out : put message options
	        msglen,			// in : message length (zero is valid)
	        Ptr_Buffer,	// in : message 
	      @ cc,					// out : completion code
	      @ rc ) ;			// out : reason code

  szOut := 'MQPUT() start. hCon('+IntToStr(hCon)+'), hObj('+IntToStr(hObj)+'). CC/RC {' + IntToStr(cc) +'/'+ IntToStr(rc) + '}.' ;
  SAGdebugMsg ( tLB, szOut ) ;	      
  
end ; // put() 
     
// ******************************************************************************     
end. // unit end