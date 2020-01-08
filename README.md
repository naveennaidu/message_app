# message_app

## API Specs

Main URL = `https://stormy-savannah-90253.herokuapp.com/api/`

| Endpoint  | Method | Parameters | Response |
| ------------- | ------------- | ------------- | ------------- |
| `/auth/register/`  | `POST`  | `name` & `password`  | status= 201 {"message": {"message": "User created successfully"},"access_token": ""} <br /> status= 500 {"name": ["has already been taken"]}|
| `/auth/login/`  | `POST`  | `name` & `password`  | status= 200 {"access_token": "","message": "Login Successful"}|
| `/connect`  | `GET`  | header > `access_token`  | `message` & `endpoint` & `partnerusername` |
| `/chatrooms`  | `GET`  | header > `access_token`  | { "chatrooms" :  [ {\"chatroom_id\":2,\"username\":\"User 1\",\"lastmessage\":{\"id\":49,\"body\":"",\"created_at\":"",\"updated_at\":"",\"chatroom_id\":2,\"user_id\":1} } ] } |
| `/chatroom/endpoint`  | `GET`  | header > `access_token`  | { "messages" : [ {"message: "", "created_at":"","sender":1} ] } |
| `/chatroom/endpoint`  | `POST`  | header > `access_token` & `text`  | {"message": "Message sent"} |
