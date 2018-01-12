cd /assets
unzip loans_updated.zip
rm -rf loans_updated.zip
sqlite3 lending_club.db < create_table.sql
