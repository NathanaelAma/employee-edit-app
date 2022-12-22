import { Admin, Resource, ListGuesser, EditGuesser} from "react-admin";
import jsonServerProvider from "ra-data-json-server";
import { UserList } from "./users";
import { Dashboard } from './Dashboard';
import { authProvider } from './authProvider';
import { PostCreate, PostEdit, PostList } from "./posts";

import PostIcon from "@mui/icons-material/Book";
import UserIcon from "@mui/icons-material/Group";



const dataProvider = jsonServerProvider('https://jsonplaceholder.typicode.com');

const App = () => (
    <Admin dataProvider={dataProvider} dashboard={Dashboard} authProvider={authProvider}>
        <Resource name="posts" list={PostList} edit={PostEdit} create={PostCreate}
        icon={PostIcon}/>
        <Resource name="users" list={UserList} recordRepresentation="name" 
        icon={UserIcon}/>  

    </Admin>
);

export default App;