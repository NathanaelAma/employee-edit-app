import { Create, DeleteButton, Edit, ReferenceInput, SimpleForm, TextInput } from 'react-admin';
import { Datagrid, List, NumberField, TextField, EditButton} from 'react-admin';
import { useRecordContext} from "react-admin";

export const EmployeeList = () => (
    <List>
        <Datagrid rowClick="edit">
            <TextField source="id" />
            <TextField source="employee_name" />
            <NumberField source="employee_or_manager" />
            <TextField source="employee_position" />
            <EditButton/>
            <DeleteButton/>
        </Datagrid>
    </List>
);

export const EmployeeEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="id" />
            <TextInput source="employee_name" />
            <DateInput source="employee_or_manager" />
            <TextInput source="employee_position" />
        </SimpleForm>
    </Edit>
);