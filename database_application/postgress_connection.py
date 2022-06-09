import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

def remove_newline(string):
    """
    remove annoyting newlines that get inserted into secrets
    :param string: String to remove newlines from
    :return: string without newlines
    """
    if isinstance(string, str):
        return string.replace("\n", "")
    return None


def none_to_zero(num):
    """
    :param num: if the parameter is none convert to 0
    :return: the number after checking if its none
    """
    if num is None:
        return 0
    return num


def pg_connection():
    """
    get a connection to postgress
    """
    try_count = 0
    while try_count < 3:
        try:
            return psycopg2.connect(
                user=remove_newline(os.getenv("DB_USER")),
                password=remove_newline(os.getenv("DB_PASS")),
                host=remove_newline(os.getenv("DB_HOST")),
                database=remove_newline(os.getenv("DB_NAME")),
                port=5432)
        except ConnectionRefusedError:
            try_count += 1
            if try_count == 3:
                raise


def execute_pg_sql(sql, parameter, select=True):
    """
    get a connection to postgress
    """
    try:
        with pg_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql, parameter)
                if select:
                    return cursor.fetchall()
                connection.commit()
                return None
    except psycopg2.OperationalError as e:
        print(e)
        return "problem connection with DataBase "


def selecting_shit():
    sql = "SELECT * FROM Customers;"
    wtf = execute_pg_sql(sql,None,True)
    print(wtf)

selecting_shit()