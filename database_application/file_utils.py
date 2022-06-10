import json
import re
import pandas as pd

from database_application.sql_utils import request_audit_config, upload_audit_config

EXCEL_FILE_PATH = r'./../excel_sheets/csv_to_python.xlsx'


def read_excel():
    """
    Reads in excel sheet 
    """
    sheets_dict = pd.ExcelFile(EXCEL_FILE_PATH)

    for sheet in sheets_dict.sheet_names:
        df = pd.read_excel(EXCEL_FILE_PATH, sheet)
        prog_names = df['Audit'].dropna()

        for csv_audit_name in prog_names:

            list_of_fields = []
            name = re.sub('[^0-9a-zA-Z', "_", csv_audit_name).strip('_')

            for i in range(0, len(df['Database Names']).dropna()):
                db_name = df['Database Names'][i]
                db_name = re.sub('[^0-9a-zA-Z', "_", db_name).strip('_')
                db_name = db_name.replace("__", "_")

                csv_name = df['CSV Names'][i]
                csv_name = re.sub('[^0-9a-zA-Z', "_", csv_name).strip('_')
                csv_name = csv_name.replace("__", "_")

                field = {
                    db_name: {
                        "code": None,
                        "type": "String",
                        "required": False,
                        "fieldName": csv_name
                    }
                }

                list_of_fields.append(field)

            name = name.replace('__', '_')

            audit_prog = {
                "file": "CSV",
                "type": "config",
                "program": name,
                "fields": list_of_fields
            }

            print(csv_audit_name)

            current_program_config_Id = request_audit_config(csv_audit_name)[0]["Upload_Definition_ID"]

            upload_audit_config(current_program_config_Id, json.dumps(audit_prog))

            with open(f'./../audit_configs/{name}.json', 'w') as studs:
                json.dump(audit_prog, studs)
            
