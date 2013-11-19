CREATE OR REPLACE FUNCTION GetFirepower(className varchar) RETURN integer IS
	classBore integer;
	classNumGuns integer;

BEGIN
	SELECT numGuns, bore into classNumGuns, classBore
	FROM classes
	WHERE class = className;
	RETURN classNumGuns * classBore * classBore * classBore;
END GetFirepower;
/

set serveroutput on format wrapped;
DECLARE
	returnValue integer;
BEGIN
	returnValue := GetFirepower('Yamato');
	DBMS_OUTPUT.put('The firepower of Yamato is ');
	DBMS_OUTPUT.put_line(returnValue);	
END;
/