const std = @import("std");

pub const GlueConnectionType = enum {
    snowflake,
    bigquery,
    documentdb,
    dynamodb,
    mysql,
    opensearch,
    oracle,
    postgresql,
    redshift,
    saphana,
    sqlserver,
    teradata,
    vertica,

    pub const json_field_names = .{
        .snowflake = "SNOWFLAKE",
        .bigquery = "BIGQUERY",
        .documentdb = "DOCUMENTDB",
        .dynamodb = "DYNAMODB",
        .mysql = "MYSQL",
        .opensearch = "OPENSEARCH",
        .oracle = "ORACLE",
        .postgresql = "POSTGRESQL",
        .redshift = "REDSHIFT",
        .saphana = "SAPHANA",
        .sqlserver = "SQLSERVER",
        .teradata = "TERADATA",
        .vertica = "VERTICA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .snowflake => "SNOWFLAKE",
            .bigquery => "BIGQUERY",
            .documentdb => "DOCUMENTDB",
            .dynamodb => "DYNAMODB",
            .mysql => "MYSQL",
            .opensearch => "OPENSEARCH",
            .oracle => "ORACLE",
            .postgresql => "POSTGRESQL",
            .redshift => "REDSHIFT",
            .saphana => "SAPHANA",
            .sqlserver => "SQLSERVER",
            .teradata => "TERADATA",
            .vertica => "VERTICA",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
