
// Type :

type
  TtimLapso = record
    Activo : boolean ;
    iLapso_Actual : integer ;
  end ; // record


// Var :

var
	timLapso : TtimLapso ;


// Calls :
	
procedure Timer_Mesura_Temps_Engegar() ;
begin
  SAGdebugMsg ( Form1.SucesosGYM, '>>> Activar timer medida lapso.' ) ;
  timLapso.iLapso_Actual := 0 ; // init lap count
  timLapso.Activo := true ;
  Form1.TimerMedidaLapso.Enabled := true ;
end ; // Timer_Mesura_Temps_Engegar()

procedure Timer_Mesura_Temps_Aturar() ;
//
// aturar, pero NO esborrar
// doncs hi ha una crida posterior per a llegir-lo
//
begin
  SAGdebugMsg ( Form1.SucesosGYM, '>>> Detener timer medida lapso.' ) ;
  Form1.TimerMedidaLapso.Enabled := false ;
  timLapso.Activo := false ;

end ; // Timer_Mesura_Temps_Aturar()

function Timer_Mesura_Temps_Llegir() : integer ;
var
  iLapso : integer ;

begin

  iLapso := timLapso.iLapso_Actual ;
  SAGdebugMsg ( Form1.SucesosGYM, '>>> Leer timer medida lapso.' ) ;
  Timer_Mesura_Temps_Llegir := iLapso ;

end ; // Timer_Mesura_Temps_Llegir()


// Init :

  TimerMedidaLapso.Enabled := false ;
  TimerMedidaLapso.Interval := 100 ; // 10 ticks per second


// Timeout :

procedure TForm1.TimerMedidaLapsoTimer(Sender: TObject);
begin
  SAGdebugMsg ( SucesosGYM, '>>> Timeout Lapso.' ) ;
  timLapso.iLapso_Actual := timLapso.iLapso_Actual +1 ;
end;
