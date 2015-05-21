unit MQAI ;

interface 

uses  SysUtils,  // StrPCopy
      MQIC ;     // we Connect() as a MQ Client !

// forward declarations :

procedure Consultar_Fondaria_de_la_Cua ( ConnH     : THandle ;
                                         szQu      : string ;
                                     var iQD       : integer ;
                                     var szPutTime : string ;
                                     var szPutDate : string ;
                                         bVerbosQ  : boolean ;
                                     var iRetCode  : integer ) ;

implementation

// ****************************************************************************

procedure Consultar_Fondaria_de_la_Cua ( ConnH     : THandle ;
                                         szQu      : string ;		// in : queue name
                                     var iQD       : integer ;		// out : queue depth
                                     var szPutTime : string ;
                                     var szPutDate : string ;
                                         bVerbosQ  : boolean ;
                                     var iRetCode  : integer ) ;	// 0 => no depth; 1 => read iQD.

var
  cc, rc : integer ;
  adminBag, responseBag, errorBag : MQHBAG ;
  qAttrsBag : MQHBAG ;                       // bag containing q attributes
  mqExecuteCC, mqExecuteRC : MQLONG ;
  numberOfBags : MQLONG ;
  i : integer ;

  qName : array [ 1 .. MQ_Q_NAME_LENGTH ] of MQCHAR ;
  qNameLength : MQLONG ;
  qDepth : MQLONG ;

  szmqPutDateLength : MQLONG ;                //  Actual length of q name
  szmqPutDate : array [ 1.. 256 ] of MQCHAR ; // string attribute returned

  szmqPutTimeLength : MQLONG ;
  szmqPutTime : array [ 1 .. 256 ] of MQCHAR ;

  szInternalTrace : string ;

begin

  iRetCode := 0 ;
  iQD := -1 ; // init output parameter
  szInternalTrace := ' ' ;

  strpcopy ( @ qName, szQu ) ;

//  debugMsg ( '>>> Consultar Q. Nom = (' + qName + ').' ) ;
  szInternalTrace := szInternalTrace + '>>> Consultar Q. Nom = (' + qName + ').\n' ;

  if ( ConnH <> 0 ) then begin

// Create an admin bag for the mqExecute call

     mqCreateBag( MQCBO_ADMIN_BAG, @ adminBag, @ cc, @ rc ) ;
//     debugResult ( 'MQ_Create_Bag', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Create_ABag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Create a response bag for the mqExecute call

     mqCreateBag( MQCBO_ADMIN_BAG, @ responseBag, @ cc, @ rc ) ;
//     debugResult ( 'MQ_Create_Bag', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Create_RBag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Put the queue name into the admin bag

     mqAddString( adminBag, MQCA_Q_NAME, MQBL_NULL_TERMINATED, @ qName, @ cc, @ rc ) ;
//     debugResult ( 'MQ_Add_String [' + szQu + ']', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Add_String [' + szQu + '] - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Put the local queue type into the admin bag

     mqAddInteger ( adminBag, MQIA_Q_TYPE, MQQT_LOCAL, @ cc, @ rc ) ;
//     debugResult ( 'MQ_Add_Integer', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Add_Integer - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

     mqAddInquiry ( adminBag, MQIACF_ALL, @ cc, @ rc ) ;
//     debugResult ( 'MQ_Add_Inquiry', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Add_Inquiry - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Send the command to find all the local queue names and queue depths.
// The mqExecute call creates the PCF structure required, sends it to
// the command server, and receives the reply from the command server into
// the response bag. The attributes are contained in system bags that are
// embedded in the response bag, one set of attributes per bag.

     mqExecute ( ConnH,                 // MQ connection handle
                 MQCMD_INQUIRE_Q,       // Command to be executed : Inquire Queue
                 MQHB_NONE,             // No options bag
                 adminBag,              // Handle to bag containing commands
                 responseBag,           // Handle to bag to receive the response
                 MQHO_NONE,             // Put msg on SYSTEM.ADMIN.COMMAND.QUEUE
                 MQHO_NONE,             // Create a dynamic q for the response
                 @ cc,                  // Completion code from the mqexecute
                 @ rc ) ;               // Reason code from mqexecute call

//     debugResult ( 'MQ_Execute', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Execute - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

     if ( rc = MQRC_CMD_SERVER_NOT_AVAILABLE ) then begin
//          debugMsg ( '--- Please start the command server: <strmqcsv QMgrName>' ) ;
          szInternalTrace := szInternalTrace + '--- Please start the Command Server: <strmqcsv QMgrName>.\n' ;

     end
     else begin

          if ( cc = MQCC_OK ) then begin

// tenim resposta :

               mqCountItems ( responseBag, MQHA_BAG_HANDLE, @ numberOfBags, @ cc, @ rc ) ;
//               debugResult ( 'MQ_Count_Items', cc, rc ) ;
               szInternalTrace := szInternalTrace + 'MQ_Count_Items - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

               if bVerbosQ then
//                  debugMsg ( '>>> CountItems >>> Num Items (' + intToStr(numberOfBags) + ').' ) ;
                    szInternalTrace := szInternalTrace + 'Num Items (' + intToStr(numberOfBags) + ').\n' ;

               for i := 0 to numberOfBags-1 do
               begin

// Get the next system bag handle out of the mqExecute response bag.
// This bag contains the queue attributes

                    mqInquireBag ( responseBag, MQHA_BAG_HANDLE, i, @ qAttrsBag, @ cc, @ rc ) ;
//                    debugResult ( 'MQ_Inquire_Bag', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_Bag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Get the queue name out of the queue attributes bag

                    mqInquireString ( qAttrsBag, MQCA_Q_NAME, 0, MQ_Q_NAME_LENGTH, @ qName, @ qNameLength, NIL, @cc, @rc ) ;
//                    debugResult ( 'MQ_Inquire_String', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_String - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Label9.Caption := 'Qnm = ' + Edit5.Text ;

// Get the depth out of the queue attributes bag

                    mqInquireInteger ( qAttrsBag, MQIA_CURRENT_Q_DEPTH, MQIND_NONE, @ qDepth, @cc, @rc ) ;
//                    debugResult ( 'MQ_Inquire_Integer', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_Integer - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

                    iRetCode := 1 ; // indicate "ok"
                    iQD := qDepth ; // set output parameter

                    if bVerbosQ then
//                         debugMsg ( '(' + intToStr(qDepth) + ') mensajes en la cola (' + qName + ').' ) ;
                         szInternalTrace := szInternalTrace + '(' + intToStr(qDepth) + ') mensajes en la cola (' + qName + ').\n' ;

               end ; { for ... }

          end
          else begin

//               debugMsg ( '--- Call to get queue attributes failed.' ) ;
               szInternalTrace := szInternalTrace + '--- Call to get queue attributes failed.\n' ;

               if ( rc = MQRCCF_COMMAND_FAILED ) then begin

// If the command fails, get the system bag handle out of the mqexecute response bag.
// This bag contains the reason from the command server why the command failed.

                    mqInquireBag ( responseBag, MQHA_BAG_HANDLE, 0, @ errorBag, @ cc, @ rc ) ;
//                    debugResult ( 'MQ_Inquire_Bag', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_Bag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

                    mqInquireInteger ( errorBag, MQIASY_COMP_CODE, MQIND_NONE, @ mqExecuteCC, @ cc, @ rc ) ;
//                    debugResult ( 'MQ_Inquire_Integer', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_Integer - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

                    mqInquireInteger ( errorBag, MQIASY_REASON, MQIND_NONE, @ mqExecuteRC, @ cc, @ rc ) ;
//                    debugResult ( 'MQ_Inquire_Integer', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_Integer - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

//                    debugMsg ( 'Command Server error : CC(' + intToStr(mqExecuteCC) + '), RC(' + intToStr(mqExecuteRC) + ').' ) ;
                    szInternalTrace := szInternalTrace + 'Command Server error : CC(' + intToStr(mqExecuteCC) + '), RC(' + intToStr(mqExecuteRC) + ').\n' ;

               end ; // rc = RCCF

               if ( rc = MQRC_CONNECTION_BROKEN ) then begin
                 iRetCode := 2 ;
               end ;

          end ; // CC not OK
     end ; // rc not SERVER not AVAILABLE.

// Now get the PUT/GET DATE/TIME using MQCMD_INQUIRE_Q_STATUS in mqExecute

     mqExecute ( ConnH,                 // MQ connection handle
                 MQCMD_INQUIRE_Q_STATUS,       // Command to be executed : Inquire Queue STATUS
                 MQHB_NONE,             // No options bag
                 adminBag,              // Handle to bag containing commands
                 responseBag,           // Handle to bag to receive the response
                 MQHO_NONE,             // Put msg on SYSTEM.ADMIN.COMMAND.QUEUE
                 MQHO_NONE,             // Create a dynamic q for the response
                 @ cc,                  // Completion code from the mqexecute
                 @ rc ) ;               // Reason code from mqexecute call

//     debugResult ( 'MQ_Execute', cc, rc ) ;
     szInternalTrace := szInternalTrace + 'MQ_Execute - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

               mqCountItems ( responseBag, MQHA_BAG_HANDLE, @ numberOfBags, @ cc, @ rc ) ;
//               debugResult ( 'MQ_Count_Items', cc, rc ) ;
               szInternalTrace := szInternalTrace + 'MQ_Count_Items - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

               if bVerbosQ then
//                    debugMsg ( '>>> CountItems >>> Num Items (' + intToStr(numberOfBags) + ').' ) ;
                    szInternalTrace := szInternalTrace + 'Num Items (' + intToStr(numberOfBags) + ').\n' ;

               for i := 0 to numberOfBags-1 do
               begin

                    mqInquireBag ( responseBag, MQHA_BAG_HANDLE, i, @ qAttrsBag, @ cc, @ rc ) ;
//                    debugResult ( 'MQ_Inquire_Bag', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_Bag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

// Get Timestamp
                    mqInquireString ( qAttrsBag,
                                      MQCACF_LAST_PUT_DATE,
                                      0,
                                      128,
                                      @ szmqPutDate,        // MQ_DATE_LENGTH
                                      @ szmqPutDateLength,
                                      NIL, @cc, @rc ) ;
//                    debugResult ( 'MQ_Inquire_String', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_String - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

                    szPutDate := szmqPutDate ;
                    SetLength ( szPutDate, MQ_DATE_LENGTH ) ;

//                    debugMsg ( 'Last Put Date (' + szPutDate + ').' ) ;
                    szInternalTrace := szInternalTrace + 'Last Put Date (' + szPutDate + ').\n' ;

// Get Timestamp
                    mqInquireString ( qAttrsBag,
                                      MQCACF_LAST_PUT_TIME,
                                      0,
                                      128,
                                      @ szmqPutTime,        // MQ_TIME_LENGTH
                                      @ szmqPutTimeLength,
                                      NIL, @cc, @rc ) ;
//                    debugResult ( 'MQ_Inquire_String', cc, rc ) ;
                    szInternalTrace := szInternalTrace + 'MQ_Inquire_String - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;

                    szPutTime := szmqPutTime ;
                    SetLength ( szPutTime, MQ_TIME_LENGTH ) ;

//                    debugMsg ( 'Last Put Time (' + szPutTime + ').' ) ;
                    szInternalTrace := szInternalTrace + 'Last Put Time (' + szPutTime + ').\n' ;

               end ; { for ... }

// Delete the admin bag if successfully created.

     if ( adminBag <> MQHB_UNUSABLE_HBAG ) then begin
          mqDeleteBag ( @ adminBag, @ cc, @ rc ) ;
//          debugResult ( 'MQ_Delete_Bag', cc, rc ) ;
          szInternalTrace := szInternalTrace + 'MQ_Delete_Bag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;
     end ;

// Delete the response bag if successfully created.

     if ( responseBag <> MQHB_UNUSABLE_HBAG) then begin
          mqDeleteBag ( @ responseBag, @ cc, @ rc ) ;
//          debugResult ( 'MQ_Delete_Bag', cc, rc ) ;
          szInternalTrace := szInternalTrace + 'MQ_Delete_Bag - CC: [' + intToStr(cc) + '], RC: [' + intToStr(rc) + '].\n' ;
     end ;

  end
  else begin
//     debugMsg ( '--- No Connection Handle yet.' ) ;
     szInternalTrace := szInternalTrace + '--- No Connection Handle yet.\n' ;
  end ;

// szQu := szInternalTrace ; // set output param ... in the future.

end ;  // Consultar_Fondaria_de_la_Cua

// *****************************************************************************


// ****************************************************************************

end.