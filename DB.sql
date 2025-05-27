-- Design a database for a social network:
-- - people's profiles (name, description, photo, city, interests);
-- - posts (description, media, hashtags, likes, views, comments);
-- - private messages and chats (only text and message read);
-- - relationships (friends, subscribers, love relationships);
-- - media (photo, audio, video).


-- PostgreSQL
CREATE TABLE "Users" (
  "Id" guid PRIMARY KEY,
  "Name" string,
  "Description" string,
  "PhotoUrl" string,
  "City" string,
  "Interests" string,
  "DateCreated" timestamp
);

CREATE TABLE "Messages" (
  "Id" guid PRIMARY KEY,
  "AuthorId" guid,
  "ChatId" guid,
  "Text" string,
  "IsSeen" bool
);

CREATE TABLE "Chats" (
  "Id" guid PRIMARY KEY,
  "DateCreated" timestamp
);

CREATE TABLE "UserChats" (
  "UserId" guid,
  "ChatId" guid,
  "DateCreated" timestamp,
  PRIMARY KEY ("UserId", "ChatId")
);

CREATE TABLE "Posts" (
  "Id" guid PRIMARY KEY,
  "UserId" guid,
  "Description" string,
  "Views" int,
  "DateCreated" timestamp
);

CREATE TABLE "Media" (
  "Id" guid PRIMARY KEY,
  "PostId" guid,
  "URL" string,
  "ContentType" string,
  "DateCreated" timestamp
);

CREATE TABLE "Tags" (
  "Id" guid PRIMARY KEY,
  "PostId" guid,
  "Text" string,
  "DateCreated" timestamp
);

CREATE TABLE "Likes" (
  "Id" guid PRIMARY KEY,
  "UserId" guid,
  "TypeId" guid
);

CREATE TABLE "LikeTypes" (
  "Id" guid PRIMARY KEY,
  "ImageURl" string
);

CREATE TABLE "Comments" (
  "Id" guid PRIMARY KEY,
  "PostId" guid,
  "UserId" guid,
  "Text" string,
  "DateCreated" timestamp
);

CREATE TABLE "UserRelations" (
  "UserId" guid,
  "RelationId" guid,
  "DateCreated" timestamp,
  PRIMARY KEY ("UserId", "RelationId")
);

CREATE TABLE "Relations" (
  "Id" guid PRIMARY KEY,
  "Text" string
);

ALTER TABLE "Likes" ADD FOREIGN KEY ("TypeId") REFERENCES "LikeTypes" ("Id");

ALTER TABLE "Posts" ADD FOREIGN KEY ("UserId") REFERENCES "Users" ("Id");

ALTER TABLE "Media" ADD FOREIGN KEY ("Id") REFERENCES "Posts" ("Id");

ALTER TABLE "Tags" ADD FOREIGN KEY ("Id") REFERENCES "Posts" ("Id");

ALTER TABLE "Likes" ADD FOREIGN KEY ("Id") REFERENCES "Posts" ("Id");

ALTER TABLE "Comments" ADD FOREIGN KEY ("PostId") REFERENCES "Posts" ("Id");

ALTER TABLE "UserChats" ADD FOREIGN KEY ("UserId") REFERENCES "Users" ("Id");

ALTER TABLE "UserChats" ADD FOREIGN KEY ("ChatId") REFERENCES "Chats" ("Id");

ALTER TABLE "Messages" ADD FOREIGN KEY ("ChatId") REFERENCES "Chats" ("Id");

ALTER TABLE "UserRelations" ADD FOREIGN KEY ("RelationId") REFERENCES "Relations" ("Id");

ALTER TABLE "UserRelations" ADD FOREIGN KEY ("UserId") REFERENCES "Users" ("Id");
