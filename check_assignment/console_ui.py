import sys
from check_assignment.constants import RESULT_SETS


def select_main_menu():
    """
    Display Main Menu
    """
    print("\nChoose an option: \n"
          "1: Result Sets - Assignment\n"
          "2: Test Youre Own Query\n"
          "3: Quit")

    try:
        main_option =int(input())
    except ValueError:
        print("not a valid entry")
        sys.exit(1)
    return main_option


def select_task():
    """
    Display Task Options 
    """
    print("\nSelect Which Task:\n"
          "1: Task-1\n"
          "2: Task-2\n"
          "3: Task-3\n"
          "4: Go Back\n"
          "5: Quit APP\n")

    try:
        task =int(input())
    except ValueError:
        print("not a valid entry")
        sys.exit(1)
    return task



def select_question(task):
    """
    Select 
    """
    print(
        "Select Which Question: \n"
        "1: Question 1 ({task}.1)\n"
        "2: Question 2 ({task}.2)\n"
        "3: Question 3 ({task}.3)\n"
        "4: Question 4 ({task}.4)\n"
        "5: Question 5 ({task}.5)\n"
        "6: Go Back (out of order)\n"
        "7: Quit APP (out of order)\n".format(task=task)
    )

    try:
        question =int(input())
    except ValueError:
        print("not a valid entry")
        sys.exit(1)

    return question


def view_answer(task, question):
    """
    Ask user to view answer 
    """
    print("View Answer?\n"
          "1: Yes\n"
          "2: No\n"
          )
    try:
        answer =int(input())
    except ValueError:
        print("not a valid entry")
        sys.exit(1)

    if answer == 1:
        print("Correct Answer: \n")
        print(RESULT_SETS["TASK"][task][question])
    else:
        sys.exit(1)
