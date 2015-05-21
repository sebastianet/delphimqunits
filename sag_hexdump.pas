unit sag_hexdump ;

//
// Hex dump of a memory area, given its pointer and length.
//
//  v 1.0 - 20121003 - inici
//  v 2.0 - 20150520 - AnsiChar to get one byte only for every char
//

interface

uses
  Windows, StdCtrls, SysUtils,
  SAG_debug ;

const

  kVersio = 'v 2.0' ;
  kData_Darrera_Modificacio = '20150520' ;  

procedure Hex_Dump ( tLB : TListBox; szId : string ; pDades : pointer ; iLlargada : integer ) ;

implementation

// ****************************************************

const HexN: array [ 0..15 ] of char = '0123456789ABCDEF' ;

function HexB ( b: byte ) : string ;
begin
  HexB:= HexN [ b shr 4 ] + HexN [ b and $0F ] ;
end;

function HexC ( c: char ) : string ;
begin
  HexC := HexB ( byte(c) ) ;
end;

function HexW ( w: word ) : string ;
begin
  HexW := HexB ( Hi(w) ) + HexB ( Lo(w) ) ;
end;

function HexDW ( i: Integer ) : string ;
begin
  HexDW := HexW ( word (i shr 16) ) + HexW ( word (i) ) ;
end;

// ============================================================================

procedure Hex_Dump ( tLB : TListBox;
                     szId : string ;
                     pDades : pointer ; iLlargada : integer ) ;
var
  iCnt    : integer ;
  szHex   : AnsiString ;   // hex translation
  szAux   : AnsiString ;   // new byte is converted to 2 hex bytes
  szAscii : AnsiString ;   // ascii translation, if possible
  cNew    : AnsiChar ;     // make sure we get only one byte

begin

  SAGdebugMsg ( tLB, '#### Hex Dump {' + szId + '}. Ptr {' + Format( '0x%8p', [pDades] ) + '}, lng {'+ IntToStr( iLlargada) + '}.' ) ;

  iCnt := 0 ;
  szHex := '' ; // init empty string
  szAux := '' ;
  szAscii := '' ;

  while ( iCnt < iLlargada ) do
  begin

    cNew := AnsiChar( pDades^) ;                        // get new char
    szAux := Format ( '%2.2X', [ byte( pDades^ ) ] ) ;  // get a byte from memory and format it
    Inc ( pByte(pDades) ) ;                             // first cast it to a pointer of a type, so the compiler knows how to increase your pointer.
    iCnt := iCnt + 1 ;

    szHex := szHex + szAux ;
    szAux := '' ;

    if ( ord ( cNew ) < $20 ) or ( ord ( cNew ) >= $7E ) then cNew := '.' ;
    szAscii := szAscii + cNew ;

    if ( length( szHex ) >= 47 ) then // 15 elements of 3 bytes + 1 element of 2 bytes
    begin

      repeat
        szHex := szHex + ' ' ;          // add a blank char
      until ( length( szHex ) >= 55 ) ; //

      SAGdebugMsg ( tLB, '#### Hex Dump. Data {' + szHex + '[' + szAscii + ']' + '}.' ) ;
      szHex := '' ;
      szAscii := '' ;

    end else begin
      szHex := szHex + '-' ;
    end ;

  end ; // while

  if ( length( szHex ) > 0 ) then begin  // there is a last line to trace

    repeat
      szHex := szHex + ' ' ; // add a blank char
    until ( length( szHex ) >= 55 ) ;

    repeat
      szAscii := szAscii + ' ' ;        // add a blank char
    until ( length( szAscii ) >= 16 ) ; // until usual width

    SAGdebugMsg ( tLB, '#### Hex Dump. Data {' + szHex + '[' + szAscii + ']' + '}.' ) ;

  end ; // last line, if any

end ; // Hex_Dump()

// ============================================================================

end.
