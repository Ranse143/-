library TourismWeb;

uses
  Web.WebBroker,
  Web.HTTPApp,
  System.SysUtils,
  System.Classes,
  WebModuleUnit in 'WebModuleUnit.pas' {WebModule1: TWebModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
end.