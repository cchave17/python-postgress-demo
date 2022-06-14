import tabulate
from check_assignment.constants import RESULT_SETS
from check_assignment.postgress_connection import execute_pg_sql

def display_table(result_set):
    """
    print result set into a table in console
    """
    results = []

    for row in result_set:
        results.append(dict(row))

    header = results[0].keys()
    rows = [x.values() for x in results]
    print(tabulate.tabulate(rows, header, tablefmt='grid'))

def validate_task(task,go_back,running):
    """
    """
    if task == 4:
        go_back = True;
        return go_back, running 

    if task > 5:
        go_back = True
        running =False
        print("ending app")
        return go_back, running
    else:
        return go_back, running

def question_selected(task,question):
    """
    Select question
    """
    query = RESULT_SETS["TASK"][task][question]
    result_set = execute_pg_sql(query, None, True)
    
    display_table(result_set)

def test_query():
    """
    """
    print("\nWrite a query: \n")
    query =input()
    result_set = execute_pg_sql(query, None, True)
    display_table(result_set)