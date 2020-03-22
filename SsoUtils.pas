{
MIT License

Copyright (c) 2020 [https://github.com/amnemonic * adam85mn_at_gmail.com]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
}
unit SsoUtils;

interface

uses OleCtrls,ComObj,Variants;

function VariantToString(AVar: OleVariant): string;


implementation


function VariantToString(AVar: OleVariant): string;
var
  i: integer;
  V: olevariant;
begin
  Result := '';
  if VarType(AVar) = (varVariant or varByRef) then
     V := Variant(TVarData(AVar).VPointer^)
  else V := AVar;

  if VarType(V) = (varByte or varArray) then
      try
        for i:=VarArrayLowBound(V,1) to VarArrayHighBound(V,1) do
           Result := Result + Chr(Byte(V[i]));
      except;
      end
    else Result := V;
end;

end.
