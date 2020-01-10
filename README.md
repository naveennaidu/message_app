
# API reference
Main URL = `https://stormy-savannah-90253.herokuapp.com/api/`

## /auth/register

### POST

#### Succesful

##### Request

Body:

```
{
  'user': {
    'name': 'Testy McTestface',
    'password': 'Geheim!'
  }
}
```

##### Response

Status: 201 Created

Body:

```
{
  'user': {
    'id': '4711',
    'name': 'Testy McTestface',
    'token': 'ABCD
  }
}
```

#### Username already registered

##### Request

Body:

```
{
  'user': {
    'name': 'Testy McTestface',
    'password': 'Geheim!'
  }
}
```

##### Response

Status: 422 Unprocessable Entity

Body:

```
{
  'errors': {
    'name': [
      'already in use'
    ]
}
```

#### Insufficient data provided

##### Request

Body:

```
{
  'user': {
    'name': 'Testy McTestface',
  }
}
```

##### Response

Status: 422 Unprocessable Entity

Body:

```
{
  'errors': {
    'password': [
      'must exist'
    ]
}
```

##### No data provided

##### Request

Body:

```
{
}
```

##### Response

Status: 400 Bad request

## /auth/login

### POST

#### Succesful

##### Request

Body:

```
{
  'user': {
    'name': 'Testy McTestface',
    'password': 'Geheim!'
  }
}
```

##### Response

Status: 200 Ok

Body:

```
{
  'user': {
    'id': '4711',
    'name': 'Testy McTestface',
    'token': 'ABCD
  }
}
```

#### Authentication wrong

##### Request

Body:

```
{
  'user': {
    'name': 'Testy McTestface',
    'password': 'Geheim'
  }
}
```

##### Response

Status: 403 Forbidden

#### Insufficient data provided

##### Request

Body:

```
{
  'user': {
    'name': 'Testy McTestface',
  }
}
```

##### Response

Status: 422 Unprocessable Entity

Body:

```
{
  'errors': {
    'password': [
      'must exist'
    ]
}
```

##### No data provided

##### Request

Body:

```
{
}
```

##### Response

Status: 400 Bad request

## /connection

### POST

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

##### Response

Status: 200 Ok

Body:

```
{
  'connection': {
    'status': 'pending'
  }
}
```

#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized

### GET

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

##### Response

Status: 200 Ok

Body:

```
{
  'connection': {
    'status': 'connected',
    'chatroom': 815,
    'other_name': 'naveen',
  }
}
```

#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized

### DELETE

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

##### Response

Status: 200 Ok

Body:

```
{
  'connection': {
    'status': 'waiting'
  }
}
```

#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized

## /chatrooms

### GET

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

##### Response

Status: 200 Ok

Body:

```
{
  'chatrooms': [
    'id': 815,
    'username': 'Other',
    'last_message': {
      'id': 1234,
      'body': 'Hello',
      'sender': 'other',
      'created_at': '2019-11-11 11:11'
    }
  ]
}
```

#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized

## /chatrooms/$ID

### GET

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

##### Response

Status: 200 Ok

Body:

```
{
  'chatroom': {
    'id': 815,
    'username': 'Other',
    'messages': [
      4,
      45,
      123,
      555
    ]
  }
}
```

#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized

## /chatrooms/$ID/messages

### GET

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

##### Response

Status: 200 Ok

Body:

```
{
  'messages': [
    {
      'id': 4,
      'body': 'Hello',
      'sender': 'other',
      'created_at': '2019-11-11 11:11'
    },
    {
      'id': 45,
      'body': 'How are you?',
      'sender': 'self',
      'created_at': '2019-11-11 11:15'
    },
    {
      'id': 123,
      'body': 'Fine, and you?',
      'sender': 'other',
      'created_at': '2019-11-11 11:23'
    },
    {
      'id': 555,
      'body': 'Me too!',
      'sender': 'self',
      'created_at': '2019-11-11 11:11'
    }
  ]
}
```

#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized

### POST

#### Succesful

##### Request

Header:

```
Authorization: Bearer ABCD
```

Body:

```
{
  'message': {
    'body': 'Hello'
  }
}
```

##### Response

Status: 200 Ok

Body:

```
{
  'message': {
    'id': 4,  
    'body': 'Hello',
    'sender': 'self',
    'created_at': '2019-11-12 13:23'
  }
}
```

#### Insufficient data provided

##### Request

Header:

```
Authorization: Bearer ABCD
```


Body:

```
{
  'message': {
  }
}
```

##### Response

Status: 422 Unprocessable Entity

Body:

```
{
  'errors': {
    'body': [
      'must exist'
    ]
}
```

##### No data provided

##### Request

Header:

```
Authorization: Bearer ABCD
```


Body:

```
{
}
```

##### Response

Status: 400 Bad request


#### Authorization wrong

##### Request

Header:

```
Authorization: Bearer ABC
```

##### Response

Status: 403 Forbidden

#### Authorization not provided

##### Response

Status: 401 Unauthorized
