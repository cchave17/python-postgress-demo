import psycopg2
import psycopg2.extras


def postgres_connection():
    """
    Get connection to postgress 
    """
    try_count = 0
    while try_count < 3:
        try:
            return psycopg2.connect(
                user="postgres",
                password="admin123",
                host="localhost",
                database="northwind",
                cursor_factory=psycopg2.extras.RealDictCursor,
                port=5432
            )
        except ConnectionRefusedError:
            try_count += 1
            if try_count == 3:
                raise


def execute_pg_sql(sql_stmt, paramater, select=True):
    """
    executes sql statements
    """
    try:
        with postgres_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql_stmt, paramater)
                if select:
                    return cursor.fetchall()
                connection.commit()
                return None
    except psycopg2.OperationalError:
        return "problem connecting to db"


def execute_multiple_statements(statements_and_values, rollback_on_error=True):
    """
    This function is not currently used, but this function or something similar is what 
    would be used when trying to execute a transactional statement
    """
    try:
        with postgres_connection() as connection:
            try:
                cursor = connection.cursor()
                #For list of sql statements and values, loop through and attempt execution
                for s_v in statements_and_values:
                    # Handle queries with and without extra parameters
                    try:
                        cursor.execute(s_v[0],s_v[1])
                    except IndexError:
                        cursor.execute(s_v[0])
                    # commit on each statement if dont care about making a 
                    # 'transaction' with every item in the s-v list
                    if not rollback_on_error:
                        connection.commit()
            except psycopg2.Error as e:
                print(e)
                # If exception, roll back transaction
                if rollback_on_error:
                    connection.rollback()
                return False
            else:
                # IF sql statements are 'executed' in correct format,
                # commit them all at once
                if rollback_on_error:
                    connection.commit()
                return True # return the cursor in case there are results to be processed 
    except psycopg2.OperationalError as e:
        print(e)
        return False 

