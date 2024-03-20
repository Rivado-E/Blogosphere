#!/bin/bash

# Define database name
DB_NAME="blog.db"

# Define SQL commands to create tables
SQL_COMMANDS=$(cat <<EOF
CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS comments (
    id INTEGER PRIMARY KEY,
    post_id INTEGER NOT NULL,
    commenter_name TEXT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);
EOF
)

# Create database file and execute SQL commands
sqlite3 "$DB_NAME" "$SQL_COMMANDS"

# Check if tables were created successfully
if [ $? -eq 0 ]; then
    echo "Database '$DB_NAME' and tables created successfully."
else
    echo "Error creating database or tables."
fi

