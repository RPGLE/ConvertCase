# ConvertCase
RPGLE Service Program for converting a string to different case types. A single exported procedure takes a varying length string and converts to the requested type of casing.

<b>Case types:</b>
<ul>
  <li>Upper case (eg, "thiS iS a String." becomes "THIS IS A STRING."</li>
  <li>Lower case (eg, "ThiS IS a String." becomes "this is a string."</li>
  <li>Title case (eg, "this IS a String." becomes "This Is A String."</li> (Not yet supported)
  <li>Pascal case (eg, "this IS a String." becomes "ThisIsAString."</li> (Not yet supported)
  <li>Camel case (eg, "this IS a String." becomes "thisIsAString."</li> (Not yet supported)
  <li>Snake case (eg, "this IS a String." becomes "this_IS_a_String"</li> (Not yet supported)
</ul>

The package will be made of four parts:
<ol>
  <li>convert.rpgle - The module containing the logic for converting the string.</li>
  <li>CONVMOD_P.rpgleinc - The copybook containing the prototype for the procedure as well as the constants required to call the procedure.</li>
  <li>CONVMOD_S.bnd - The service program containing the signature.</li>
  <li>CONVMOD (binding directory) - This is not part of the package but there are commands that need to be run to create this in order for the package to work.</li>
</ol>
