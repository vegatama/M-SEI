# file ini merupakan perintah koneksi ke database mysql
from app import app
from flaskext.mysql import MySQL

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'magang-sei'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)