
from check_assignment.data_utils import question_selected, test_query, validate_task
from check_assignment.console_ui import select_main_menu, select_question, select_task, view_answer

def run_app():
    """
    Run main application
    """
    running = True

    while running:
        main_select = select_main_menu()
        go_back = False 
        
        while go_back == False : 
            if main_select == 1:

                task = select_task()
                go_back, running = validate_task(task,go_back,running)
                if go_back or running == False:
                    break

                question = select_question(task)
                question_selected(task, question)
                view_answer(task, question)
                go_back = True

            elif main_select == 2:
                test_query()
                running = False
                go_back = True

            elif main_select == 3:
                running = False
                go_back = True
            else:
                running = False
                go_back = True
