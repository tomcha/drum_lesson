CREATE TABLE IF NOT EXISTS pictures(
  id INTEGER PRIMARY KEY NOT NULL,
  realname text NOT NULL,
  md5hash text NOT NULL,
  owner_id INTEGER NOT NULL,
  created_at text NOT NULL,
  updated_at text NOT NULL
);
