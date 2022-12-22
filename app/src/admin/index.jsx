// in src/admin/index.tsx
import { Admin, Resource, ListGuesser } from "react-admin";
import jsonServerProvider from "ra-data-json-server";

const dataProvider = jsonServerProvider("https://localhost:8080/api/");

const App = () => (
  <Admin dataProvider={jsonServerProvider('https://jsonplaceholder.typicode.com')}>
        {/* complete CRUD pages for posts */}
        <Resource name="posts" list={PostList} create={PostCreate} edit={PostEdit} show={PostShow} />
        {/* read-only user list */}
        <Resource name="users" list={UserList} />
        {/* no show page for the comments resource */}
        <Resource name="comments" list={CommentList} create={CommentCreate} edit={CommentEdit} icon={CommentIcon} />
    </Admin>
);

export default App;