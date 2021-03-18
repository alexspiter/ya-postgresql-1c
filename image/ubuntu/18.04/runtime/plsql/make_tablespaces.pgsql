-- https://dba.stackexchange.com/questions/150148/how-to-create-tablespace-if-it-does-not-exist
CREATE OR REPLACE FUNCTION make_tablespace(tablespace text,
                                           directory text,
                                           owner text)
  RETURNS void AS
$func$
BEGIN
   IF tablespace <> '' THEN  -- catches '' *and* NULL
      -- do nothing
   ELSE
      RAISE EXCEPTION 'No tablespace.';
   END IF;

   IF EXISTS (SELECT 1 FROM pg_tablespace WHERE spcname = tablespace) THEN
      RAISE NOTICE 'Tablespace % already exists.', tablespace;
   ELSE
   	  IF directory <> '' THEN
   	  ELSE
      	RAISE EXCEPTION 'No directory.';
   	  END IF;

   	  IF owner <> '' THEN
      ELSE
      	RAISE NOTICE 'No owner. Will be set to postgres';
        owner = 'postgres';
   	  END IF;

   	  PERFORM dblink_connect('dbname=postgres'::text);  -- name of foreign server
   	  PERFORM dblink_exec(format('CREATE TABLESPACE %I OWNER %I LOCATION %L', tablespace, owner, directory));
      RAISE NOTICE 'Tablespace % created.', tablespace;
      PERFORM dblink_disconnect();
  END IF;
END
$func$  LANGUAGE plpgsql;
