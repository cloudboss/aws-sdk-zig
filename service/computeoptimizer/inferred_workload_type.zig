pub const InferredWorkloadType = enum {
    amazon_emr,
    apache_cassandra,
    apache_hadoop,
    memcached,
    nginx,
    postgre_sql,
    redis,
    kafka,
    sqlserver,

    pub const json_field_names = .{
        .amazon_emr = "AMAZON_EMR",
        .apache_cassandra = "APACHE_CASSANDRA",
        .apache_hadoop = "APACHE_HADOOP",
        .memcached = "MEMCACHED",
        .nginx = "NGINX",
        .postgre_sql = "POSTGRE_SQL",
        .redis = "REDIS",
        .kafka = "KAFKA",
        .sqlserver = "SQLSERVER",
    };
};
