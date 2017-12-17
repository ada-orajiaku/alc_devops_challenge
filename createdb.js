db.createUser(
    {
      user: "john",
      pwd: "doe"
      roles: [
         { role: "dbOwner", db: "your_database" }
      ]
    }
,
    {
        w: "majority",
        wtimeout: 5000
    }
);
db.createCollection("databaseName");