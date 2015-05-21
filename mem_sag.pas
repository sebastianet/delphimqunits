unit mem_sag ;

interface

uses
  Windows, SysUtils ;

const

  Versio = 'v 1.0, 13/03/2007' ;

function Mostrar_Memory_Status (  ) : string ;
function iGet_Memory_Status (  ) : integer ;

implementation

function Mostrar_Memory_Status (  ) : string ;

var MemoryStatus: TMemoryStatus;
begin

  MemoryStatus.dwLength := SizeOf(MemoryStatus) ;
  GlobalMemoryStatus(MemoryStatus) ;
  
  with MemoryStatus do begin

    Mostrar_Memory_Status := IntToStr(dwAvailVirtual) ;

  end;
end ; // Mostrar_Memory_Status


function iGet_Memory_Status (  ) : integer ;
var MemoryStatus: TMemoryStatus;
begin

  MemoryStatus.dwLength := SizeOf(MemoryStatus) ;
  GlobalMemoryStatus(MemoryStatus) ;
  
  with MemoryStatus do begin

    iGet_Memory_Status := dwAvailVirtual ;

  end;
end ; // iGet_Memory_Status


end. // unit end
