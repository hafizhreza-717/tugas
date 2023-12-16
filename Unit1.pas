unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    ToolBar1: TToolBar;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses FMX.TextLayout;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
Var E,A:  Integer;
    I:  TlistViewItem;
    S: String;
    T: TlistItemText;
    W,H: Single;
    L: TTextLayout;
    R: TRectF;
begin
  E:=Random(10);

  ListView1.BeginUpdate;

  I:=ListView1.items.Add;

  S:='Eintrage ' + IntToStr (E) + LineFeed;
  if E = 0 then S:=S + IntToStr (0) + '. Zeile';
  for A := 1 to E
    do begin
      S:=S + IntToStr (A)  + '. Zeile';
      if A < E then S:= S + LineFeed;

    end;


  I.Text := S;
  T:=  I.Objects.TextObject;
  I.Objects.AccessoryObject.Visible:=False;

  With ListView1
    do begin
      W:= Width - ItemSpaces.Left - ItemSpaces.Right;
      H:= ItemSpaces.Top - ItemSpaces.Bottom;
    end;

  L:= TTextLayoutManager.DefaultTextLayout.Create;
  try
    L.BeginUpdate;
    L.Font := T.Font;
    L.VerticalAlign := T.TextVertAlign;
    L.HorizontalAlign := T.TextAlign;
    L.WordWrap := T.WordWrap;
    L.Trimming := T.Trimming;
    L.TopLeft := PointF(0,0);
    L.MaxSize := PointF(W, TTextLayout.MaxLayoutSize.Y);
    L.Color := T.TextColor;
    L.Text := T.Text;

    L.EndUpdate;

    R:= L.TextRect;

  finally
    L.Free;

  end;

  I.Height:= Round( R.Height + H);

  Listview1.EndUpdate;


end;

procedure TForm1.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
AItem.Objects.AccessoryObject.Visible:=False;
end;

Initialization


  Randseed := 42;


end.
