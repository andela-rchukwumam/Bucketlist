[![Code Climate](https://codeclimate.com/github/andela-rchukwumam/Bucketlist/badges/gpa.svg)](https://codeclimate.com/github/andela-rchukwumam/Bucketlist)
[![Coverage Status](https://coveralls.io/repos/andela-rchukwumam/Bucketlist/badge.svg?branch=master&service=github)](https://coveralls.io/github/andela-rchukwumam/Bucketlist?branch=master)

## Description
This is an API for a bucket list service. Specification for the API is shown below.

## End Points Functionalities
|End Point| Function  |
|---------------------|:----:|
|**POST /auth/login:** |Logs a user in
| **GET /auth/logout:**| Logs a user out
| **POST /lists:**| Creates a new bucket list
| **GET /lists:**| Lists all the created bucket lists
|**GET /lists/(id):**| Gets a single bucket list
| **PUT /lists/(id):** |Updates this single bucket list
| **DELETE /lists/(id):**| Deletes this single bucket list
| **POST /lists/(id)/items:** |Creates a new item in bucket list
|**PUT /lists/(id)/items/(item_id):**| Updates a bucket list item
|**DELETE /lists/(id)/items/(item_id):**| Deletes an item in a bucket list

## Data Model
 The JSON data model for a bucket list and a bucket list item is shown below.

```
{
  id: 1,
  name: “BucketList1”,
  date_created: “2015-08-12 11:57:23”,
  date_modified: “2015-08-12 11:57:23”
  created_by: “Owner's Name”
    items: [
         {
               id: 1,
               name: “I need to do X”,
               date_created: “2015-08-12 11:57:23”,
               date_modified: “2015-08-12 11:57:23”,
               done: False
             }
           ]
}
```

## Authentication
Json Web Tokens(JWT), Token Based System was used for this API. With this, some end points are not accessible to unauthenticated users. Access control mapping is listed below.

### End Point and Public Access
|End Point| Publicity  |
|---------------------|:----:|
|**POST /auth/login:**| TRUE |
| **GET /auth/logout:**| FALSE|
| **POST /lists:**| FALSE|
| **GET /lists:**| FALSE|
| **GET /lists/(id):**| FALSE|
| **PUT /lists/(id):**| FALSE|
| **DELETE /lists/(id):**| FALSE |
|**POST /lists/(id)/items:**|  FALSE|
| **PUT /lists/(id)/items/(item_id):**| FALSE|
| **DELETE /lists/(id)/items/(item_id):**| FALSE|

## Pagination
This API is paginated such that users can specify the number of results they would like to have via a `GET parameter` `limit`.

#### Example

**Request:**
```
GET https://ruth-list.herokuapp.com/api/v1/lists?page=2&limit=20
```

**Response:**
```
20 bucket list records belonging to the logged in user starting from the 21st bucket list .
```

  ## Searching by Name
  Users can search for bucket list by its name using a `GET parameter` `q`.
  #### Example

  **Request:**
  ```
  GET https://ruth-list.herokuapp.com/api/v1/lists?q=bucket1
  ```

  **Response:**
  ```
  Bucket lists with the string “bucket1” in their name.
  ```

## Versions
This API has only one version for now, and it can be accessed via -
```
https://ruth-list.herokuapp.com/api/v1/endpoint
```

## Use Online
 This API is currently hosted on:
 [https://ruth-list.herokuapp.com/](https://ruth-list.herokuapp.com/)

## Contributions
 This API is open source and contributions are welcomed. You can clone the [Github](https://github.com/andela-rchukwumam/Bucketlist) repository and raise a `pull request` for your contributions.  
