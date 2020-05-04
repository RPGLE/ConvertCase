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
