pub const ClientPasswordAuthType = enum {
    mysql_native_password,
    mysql_caching_sha2_password,
    postgres_scram_sha_256,
    postgres_md5,
    sql_server_authentication,
};
