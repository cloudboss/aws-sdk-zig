const std = @import("std");

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
        .amazon_emr = "AmazonEmr",
        .apache_cassandra = "ApacheCassandra",
        .apache_hadoop = "ApacheHadoop",
        .memcached = "Memcached",
        .nginx = "Nginx",
        .postgre_sql = "PostgreSql",
        .redis = "Redis",
        .kafka = "Kafka",
        .sqlserver = "SQLServer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_emr => "AmazonEmr",
            .apache_cassandra => "ApacheCassandra",
            .apache_hadoop => "ApacheHadoop",
            .memcached => "Memcached",
            .nginx => "Nginx",
            .postgre_sql => "PostgreSql",
            .redis => "Redis",
            .kafka => "Kafka",
            .sqlserver => "SQLServer",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
