drop database jwdb;
create database jwdb;
grant all privileges on jwdb.* to 'formman'@'localhost' identified by 'formman';
flush privileges;

