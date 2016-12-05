# Database API
This API uses Realm DB framework to support Chipmunk's database layer. The API contains operations on Client, Post, and Session classes. There are many useful operations such as creating and adding clients; creating and adding posts; and various methods of sorting the clients and posts collections.

#### API

#
##
### CHClients - APIs related to the collection of client/attendees who join a session

## creating a client

Request:

PUT  -  addOrUpdateClient(CHClient)
{
    "username" : "Victor"
}

Response:

{
    "username" : "Victor",
    "uuid" : "1",
    "session_id" : "1",
    "join_time" : "18:40:53",
}

## delete a client. The username and uuid is required.

Request:

DELETE  -  deleteClient(CHClient)
{
    "username" : "Victor",
    "uuid" : "1"
}

## get all existing clients in a session

GET  -  allClients()
[
    {
        "username" : "Victor",
        "uuid" : "1",
        "session_id" : "1",
        "join_time" : "18:40:53"
    },
    {
        "username" : "Harold",
        "uuid" : "2",
        "session_id" : "1",
        "join_time" : "19:32:23"
    }
]

# Other functions for retrieving the entire session can be used to return a sorted collection. These include the following:

allClientsByName() returns a collection of clients ordered by username;

allClientsByJoinTime() returns a collection of clients ordered by last to join appearing first.

## get all existing clients in a particular session

Request:

POST - allClientsInSession(String)
{
        "uuid" : "1"
}

Response:

[
    {
        "username" : "Victor",
        "uuid" : "1",
        "session_id" : "1",
        "join_time" : "18:40:53"
    },
    {
        "username" : "Harold",
        "uuid" : "2",
        "session_id" : "1",
        "join_time" : "19:32:23"
    }
]

## get all existing clients that have a particular username

POST - findClientsByName(String)
{
    "username" : "Victor"
}

Response:

[
    {
        "username" : "Victor",
        "uuid" : "1",
        "session_id" : "1",
        "join_time" : "18:40:53"
    }
]

#
##
###CHPosts - APIs related to the content submissions.

## adding a new submission to the posts collection

Request:

PUT - addOrUpdatePost(CHPost)
{
    "uuid" : "1",
    "post_type" : "text",
    "mod_status" : "false",
    "submission_time" : "19:54:12",
}

Response:

{
    "uuid" : "1",
    "post_type" : "text",
    "body" : "here is some text",
    "image_url" : "",
    "image_data" : "",
    "video_url" : "",
    "mod_status" : "false",
    "submission_time" : "19:54:12",
    "mod_acceptance_time" : ""
}

## deleting a submission/post from the collection

Request:

DELETE - deletePost(CHPost)
{
    "uuid" : "1"
}

## get all posts in the collection

GET - getAllPosts()

Response:

[
    {
        "uuid" : "1",
        "post_type" : "text",
        "body" : "here is some text",
        "image_url" : "",
        "image_data" : "",
        "video_url" : "",
        "mod_status" : "true",
        "submission_time" : "19:54:12",
        "mod_acceptance_time" : ""
    },
    {
        "uuid" : "2",
        "post_type" : "image",
        "body" : "a written image caption here",
        "image_url" : "https://i.redditmedia.com/1stcvCE3BWfa0G3AP4gM2qf7IqsKTGI3LM50YG4vep4.png?w=684&s=99178c048ab7f6c152bbe1fdc82c7ebb",
        "image_data" : "/path/to/file",
        "video_url" : "",
        "mod_status" : "false",
        "submission_time" : "19:54:12",
        "mod_acceptance_time" : ""
    }
]

## get all submissions that are marked as accepted by the host

GET - getAllModeratedPosts()

Response:

[
    {
        "uuid" : "1",
        "post_type" : "text",
        "body" : "here is some text",
        "image_url" : "",
        "image_data" : "",
        "video_url" : "",
        "mod_status" : "true",
        "submission_time" : "19:54:12",
        "mod_acceptance_time" : ""
    }
]

## get all submissions that are ordered by acceptance time (they are moderated submissions)

GET - getPostsAcceptanceTimeSorted()

Response:

[
    {
        "uuid" : "1",
        "post_type" : "text",
        "body" : "here is some text",
        "image_url" : "",
        "image_data" : "",
        "video_url" : "",
        "mod_status" : "true",
        "submission_time" : "19:54:12",
        "mod_acceptance_time" : ""
    },
    {
        "uuid" : "2",
        "post_type" : "image",
        "body" : "a written image caption here",
        "image_url" : "https://i.redditmedia.com/1stcvCE3BWfa0G3AP4gM2qf7IqsKTGI3LM50YG4vep4.png?w=684&s=99178c048ab7f6c152bbe1fdc82c7ebb",
        "image_data" : "/path/to/file",
        "video_url" : "",
        "mod_status" : "true",
        "submission_time" : "19:54:12",
        "mod_acceptance_time" : ""
    }
]

GET - getAllPostsToModerate()

Response:

[
    {
        "uuid" : "1",
        "post_type" : "text",
        "body" : "here is some text",
        "image_url" : "",
        "image_data" : "",
        "video_url" : "",
        "mod_status" : "false",
        "submission_time" : "19:54:12",
        "mod_acceptance_time" : ""
    },
    {
        "uuid" : "2",
        "post_type" : "image",
        "body" : "a written image caption here",
        "image_url" : "https://i.redditmedia.com/1stcvCE3BWfa0G3AP4gM2qf7IqsKTGI3LM50YG4vep4.png?w=684&s=99178c048ab7f6c152bbe1fdc82c7ebb",
        "image_data" : "/path/to/file",
        "video_url" : "",
        "mod_status" : "false",
        "submission_time" : "18:34:52",
        "mod_acceptance_time" : ""
    }
]

