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
//                            => TITLE_CASE ('3')
//                            => PASCAL_CASE ('4') NOT YET SUPPORTED!
//                            => CAMEL_CASE ('5') NOT YET SUPPORTED!
//--------------------------------------------------------------------------------------------------
dcl-proc convertCase export;
  dcl-pi convertCase varchar(1024);
    stringToConvert varchar(1024) const;
    caseRequested char(1) const;
  end-pi;
  
  dcl-c UPPER_CASE_CHARACTERS const('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  dcl-c LOWER_CASE_CHARACTERS const('abcdefghijklmnopqrstuvwxyz');

  dcl-s convertedString varchar(1024) inz;
  dcl-s pos int(10:0) inz;
  dcl-s previousPos int(10:0) inz;
  dcl-s len int(10:0) inz;

  if caseRequested = UPPER_CASE;
    convertedString = %xlate(LOWER_CASE_CHARACTERS
                           : UPPER_CASE_CHARACTERS
                           : %trim(stringToConvert));
  elseif caseRequested = LOWER_CASE;
    convertedString = %xlate(UPPER_CASE_CHARACTERS
                           : LOWER_CASE_CHARACTERS
                           : %trim(stringToConvert));
  elseif caseRequested = TITLE_CASE;
    // Convert the whole thing to lower case with the very first character being upper.
    // We must make sure the string is longer than two positions to do this.
    if %len(%trim(stringToConvert)) >= 2;
      convertedString = %xlate(LOWER_CASE_CHARACTERS
                             : UPPER_CASE_CHARACTERS
                             : %subst(%trim(stringToConvert) : 1 : 1))
                      + %xlate(UPPER_CASE_CHARACTERS
                             : LOWER_CASE_CHARACTERS
                             : %subst(%trim(stringToConvert) : 2));

      // Now loop over the string and find the new words by looking for blanks.
      len = %len(convertedString);
      pos = %scan(' ' : convertedString);
      dow pos > *zero;
        // Make sure we stay within the bounds of the string.
        if pos + 2 <= len;
          convertedString = %subst(convertedString : 1 : pos)
                          + %xlate(LOWER_CASE_CHARACTERS
                                 : UPPER_CASE_CHARACTERS
                                 : %subst(convertedString : pos + 1 : 1))
                          + %subst(convertedString : pos + 2);
          previousPos = pos;
          pos = %scan(' ' : convertedString : previousPos + 1);

        // If there is just one character after the space, then capitalize it and leave.
        else;
          convertedString = %subst(convertedString : 1 : pos)
                          + %xlate(LOWER_CASE_CHARACTERS
                                 : UPPER_CASE_CHARACTERS
                                 : %subst(convertedString : pos + 1 : 1));
          leave;
        endif;
      enddo;

    // If the length is less than 2, then we'll just uppercase this first character and send it on
    // it's merry way.
    else;
      convertedString = %xlate(LOWER_CASE_CHARACTERS
                             : UPPER_CASE_CHARACTERS
                             : %trim(stringToConvert));
    endif;

  elseif caseRequested = PASCAL_CASE;
    // To come...
  elseif caseRequested = CAMEL_CASE;
    // To come...
  endif;

  return convertedString;
end-proc;   
