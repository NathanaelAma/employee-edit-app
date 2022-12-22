import React from 'react'
import simpleRestProvider from 'ra-data-simple-rest';
import { Admin, Resource, ListGuesser, fetchUtils , EditGuesser} from 'react-admin';
import { EmployeeEdit, EmployeeList } from './components/employee';

const dataProvider = simpleRestProvider('http://localhost:8080/api');

export const Employee = () => {
  return (
    <Admin dataProvider={dataProvider}>
        <Resource name="employees" list={EmployeeList} edit={EmployeeEdit}></Resource>
    </Admin>
  )
}

const EmployeeTitle = () => {
  const record = useRecordContext();
  return <span>Post {record ? `"${record.title}"` : ''}</span>;
};
