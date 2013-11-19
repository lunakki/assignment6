CREATE OR REPLACE FUNCTION GetNetWorth(studioName CHAR) RETURN INTEGER IS
netWorthRet INTEGER;
BEGIN
	SELECT netWorth into netWorthRet
	FROM Studio, MovieExec
	WHERE Studio.name = studioName AND presC# = cert#;
	RETURN netWorthRet;
END GetNetWorth;
/

CREATE OR REPLACE FUNCTION IsStarOrExec(personName CHAR, personAddress VARCHAR) RETURN INTEGER IS
starCount NUMBER;
execCount NUMBER;
BEGIN
	SELECT count(*) into starCount
	FROM MovieStar 
	WHERE name = personName AND address = personAddress;
	
	SELECT count(*) into execCount
	FROM MovieExec
	WHERE name = personName AND address = personAddress;

	IF starCount = 0 
	THEN
		IF execCount = 0
		THEN
			RETURN 4;
		ELSE
			RETURN 2;
		END IF;
	ELSE
		IF execCount = 0
		THEN
			RETURN 1;
		ELSE
			RETURN 3;
		END IF;
	END IF;
END IsStarOrExec;
/

set serveroutput on format wrapped;
DECLARE
	returnValue INTEGER;
BEGIN
	returnValue := GetNetWorth('MGM');
	DBMS_OUTPUT.put('The salary of the exec at MGM is $');
	DBMS_OUTPUT.put_line(returnValue);
	returnValue := IsStarOrExec('Sandra Bullock', 'America');
	DBMS_OUTPUT.put('The return value for looking up Sandra Bullock in America is ');
	DBMS_OUTPUT.put_line(returnValue);
	returnValue := IsStarOrExec('Nobody', 'Nowhere');
	DBMS_OUTPUT.put('The return value for looking up Nobody in Nowhere is ');
	DBMS_OUTPUT.put_line(returnValue);
	returnValue := IsStarOrExec('Ronald Meyer', 'Malibu');
	DBMS_OUTPUT.put('The return value for looking up Ronald Meyer in Malibu is ');
	DBMS_OUTPUT.put_line(returnValue);

	
END;
/