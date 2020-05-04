**FREE
//--------------------------------------------------------------------------------------------------
// MIT License
// Copyright (c) 2020 Ghost +
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//-------------------------------------------------------------------------------------------------- 
ctl-opt option(*srcstmt: *nodebugio) datfmt(*iso) nomain;

/include QRPGLESRC,CONVMOD_P

//--------------------------------------------------------------------------------------------------
// Procedure  : convertCase
// Purpose    : Convert to Upper or Lower case (we'll add other cases in the future).
// Returns    : convertedString => Contains the result.
// Parameter/s: stringToConvert => Our string to convert.
//              caseRequested => UPPER_CASE ('1')
//                            => LOWER_CASE ('2')
//                            => PROPER_CASE ('3') NOT YET SUPPORTED!
//                            => PASCAL_CASE ('4') NOT YET SUPPORTED!
//                            => CAMEL_CASE ('5') NOT YET SUPPORTED!
//              startPosition => Optional parameter, decides where we'll start from.
//--------------------------------------------------------------------------------------------------
dcl-proc convertCase export;
  dcl-pi convertCase varchar(1024);
    stringToConvert varchar(1024) const;
    caseRequested char(1) const;
    startPosition zoned(3:0) options(*nopass) const;
  end-pi;

  dcl-c UPPER_CASE_CHARACTERS const('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  dcl-c LOWER_CASE_CHARACTERS const('abcdefghijklmnopqrstuvwxyz');

  dcl-s convertedString varchar(1024) inz;
  dcl-s ourRealStartPosition zoned(2:0) inz(1);

  // If the caller requested a particular position to start from, use it, otherwise we'll
  // just stick with our first position - using this var makes our code simpler.
  if %parms() >= %parmnum(startPosition);
    ourRealStartPosition = startPosition;
  endif;

  if caseRequested = UPPER_CASE;
    convertedString = %xlate(LOWER_CASE_CHARACTERS
                           : UPPER_CASE_CHARACTERS
                           : stringToConvert
                           : ourRealStartPosition);
  elseif caseRequested = LOWER_CASE;
    convertedString = %xlate(UPPER_CASE_CHARACTERS
                           : LOWER_CASE_CHARACTERS
                           : stringToConvert
                           : ourRealStartPosition);
  elseif caseRequested = PROPER_CASE;
    // To come...
  elseif caseRequested = PASCAL_CASE;
    // To come...
  elseif caseRequested = CAMEL_CASE;
    // To come...
  endif;

  return convertedString;
end-proc;   
