unit WebModuleUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  FireDAC.Comp.Client,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef;

type
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure WebModule1DefaultHandlerAction(
      Sender: TObject;
      Request: TWebRequest;
      Response: TWebResponse;
      var Handled: Boolean);
    procedure WebModule1Create(Sender: TObject);
  private
    function GetToursHTML: string;
  end;

var
  WebModule1: TWebModule1;

implementation

{$R *.dfm}

procedure TWebModule1.WebModule1Create(Sender: TObject);
begin
  FDConnection1.LoginPrompt := False;

  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('DriverID=MSSQL');
  FDConnection1.Params.Add('Server=localhost');
  FDConnection1.Params.Add('Database=Tourism');
  FDConnection1.Params.Add('OSAuthent=Yes');

  FDConnection1.Connected := True;
end;

function TWebModule1.GetToursHTML: string;
var
  HTML: string;
begin
  HTML :=
    '<!DOCTYPE html>' +
    '<html lang="ru">' +
    '<head>' +
    '<meta charset="UTF-8">' +
    '<meta name="viewport" content="width=device-width,initial-scale=1">' +
    '<title>Туристическое агентство</title>' +

    '<style>' +
    'body {' +
      'font-family: Arial, sans-serif;' +
      'margin: 0;' +
      'background: #f4f6f8;' +
      'color: #222;' +
    '}' +

    '.header {' +
      'background: #1f2937;' +
      'color: white;' +
      'padding: 25px 40px;' +
    '}' +

    '.header h1 {' +
      'margin: 0;' +
    '}' +

    '.container {' +
      'max-width: 1200px;' +
      'margin: 40px auto;' +
      'padding: 0 20px;' +
    '}' +

    '.card {' +
      'background: white;' +
      'padding: 25px;' +
      'border-radius: 10px;' +
      'box-shadow: 0 2px 10px rgba(0,0,0,.08);' +
    '}' +

    'table {' +
      'width: 100%;' +
      'border-collapse: collapse;' +
      'margin-top: 20px;' +
    '}' +

    'th, td {' +
      'padding: 12px;' +
      'border-bottom: 1px solid #ddd;' +
      'text-align: left;' +
    '}' +

    'th {' +
      'background: #374151;' +
      'color: white;' +
    '}' +

    'tr:hover {' +
      'background: #f3f4f6;' +
    '}' +

    '.price {' +
      'font-weight: bold;' +
    '}' +

    '</style>' +
    '</head>' +

    '<body>' +

    '<div class="header">' +
      '<h1>Туристическое агентство</h1>' +
      '<p>WEB-информационная система</p>' +
    '</div>' +

    '<div class="container">' +

    '<div class="card">' +
      '<h2>Доступные туры</h2>' +

      '<table>' +
      '<tr>' +
        '<th>Турист</th>' +
        '<th>Страна</th>' +
        '<th>Город</th>' +
        '<th>Тип тура</th>' +
        '<th>Начало</th>' +
        '<th>Окончание</th>' +
        '<th>Стоимость</th>' +
      '</tr>';

  FDQuery1.Close;

  FDQuery1.SQL.Text :=
    'SELECT ' +
    'tr.FullName AS Tourist, ' +
    'c.CountryName AS Country, ' +
    'ci.CityName AS City, ' +
    'tt.TypeName AS TourType, ' +
    't.StartDate, ' +
    't.EndDate, ' +
    't.Price ' +
    'FROM Tours t ' +
    'INNER JOIN Tourists tr ' +
    'ON t.TouristID = tr.TouristID ' +
    'INNER JOIN Cities ci ' +
    'ON t.CityID = ci.CityID ' +
    'INNER JOIN Countries c ' +
    'ON ci.CountryID = c.CountryID ' +
    'INNER JOIN TourTypes tt ' +
    'ON t.TypeID = tt.TypeID ' +
    'ORDER BY t.StartDate';

  FDQuery1.Open;

  while not FDQuery1.Eof do
  begin
    HTML := HTML +
      '<tr>' +
      '<td>' +
        FDQuery1.FieldByName('Tourist').AsString +
      '</td>' +

      '<td>' +
        FDQuery1.FieldByName('Country').AsString +
      '</td>' +

      '<td>' +
        FDQuery1.FieldByName('City').AsString +
      '</td>' +

      '<td>' +
        FDQuery1.FieldByName('TourType').AsString +
      '</td>' +

      '<td>' +
        FDQuery1.FieldByName('StartDate').AsString +
      '</td>' +

      '<td>' +
        FDQuery1.FieldByName('EndDate').AsString +
      '</td>' +

      '<td class="price">' +
        FDQuery1.FieldByName('Price').AsString +
        ' руб.' +
      '</td>' +

      '</tr>';

    FDQuery1.Next;
  end;

  HTML := HTML +
      '</table>' +
    '</div>' +
    '</div>' +

    '</body>' +
    '</html>';

  Result := HTML;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(
  Sender: TObject;
  Request: TWebRequest;
  Response: TWebResponse;
  var Handled: Boolean);
begin
  try
    Response.ContentType := 'text/html; charset=utf-8';
    Response.Content := GetToursHTML;
    Response.StatusCode := 200;
    Handled := True;
  except
    on E: Exception do
    begin
      Response.StatusCode := 500;
      Response.ContentType := 'text/html; charset=utf-8';

      Response.Content :=
        '<h1>Ошибка приложения</h1>' +
        '<p>' + E.Message + '</p>';

      Handled := True;
    end;
  end;
end;

end.