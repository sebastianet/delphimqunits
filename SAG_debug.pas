unit SAG_debug ;

//
// Per ajudar a la depuracio, escrivim missatges en una ListBox, even no pointer is provided.
//
// Versions :
//
//	1.1 - Max Num Items es 100.000
//	1.2 - Posar "id" de versio a la trassa
//  1.3 - MaxNumItems = 20 per prevenir MemoryLeak
//  1.4 - deixem 5 despres de esborrar
//  1.5 - verify we have a tLB pointer
//

//
// Com fer servir : 
// a) posar "SAG_debug" al "Uses" ...
// b) fer servir SAGdebugMsg ( tLB : TListBox; s: string ) ;
// c) posar c:\sebas\delphi\units a Search Path de Options de Project
//

interface

uses
  Windows, StdCtrls, SysUtils ;

const

  kszVersio = 'v 1.6' ;
  Data_Darrera_Modificacio = '2012/10/03' ;  

procedure SAGdebugMsg ( tLB : TListBox; s: string ) ;
procedure SAGdebugClearLB ( tLB : TListBox ) ;

implementation

// +++

procedure SAGdebugMsg ( tLB : TListBox; s: string ) ;
const
	MaxNumofItems = 1400000000 ;     // amb 100.000 hi ha Page Faults & Memory Leak ; 40 is OK (?)
	NumItemstoDelete = 35 ;

var
	i : integer ;
begin

  if ( tLB <> nil ) then // log only if TCB pointer
  
	  with tLB do begin

		  if Items.Count > MaxNumofItems then begin
			  for i:=1 to NumItemstoDelete do Items.Delete(0);
		  end ;
		  Items.Add ( dateTimeToStr ( now ) +' {'+ kszVersio +'}'+ ' ['+inttostr(items.count)+'] ' + s ) ;
		  ItemIndex := Count - 1 ; // focus on last item
//      ItemIndex := -1 ; // no focus at all

	  end ;
	
end ; (* debugMsg *)


procedure SAGdebugClearLB ( tLB : TListBox ) ;
var
	i : integer ;

begin

	with tLB do begin

		for i:=1 to Items.Count do Items.Delete(0);
		ItemIndex := -1 ; // no focus at all
	end;

end ; // SAGdebugClearLB

// ---

end. // unit end
