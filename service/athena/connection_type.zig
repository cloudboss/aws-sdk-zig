const std = @import("std");

pub const ConnectionType = enum {
    dynamodb,
    mysql,
    postgresql,
    redshift,
    oracle,
    synapse,
    sqlserver,
    db2,
    opensearch,
    bigquery,
    googlecloudstorage,
    hbase,
    documentdb,
    cmdb,
    tpcds,
    timestream,
    saphana,
    snowflake,
    datalakegen2,
    db2_as400,

    pub const json_field_names = .{
        .dynamodb = "DYNAMODB",
        .mysql = "MYSQL",
        .postgresql = "POSTGRESQL",
        .redshift = "REDSHIFT",
        .oracle = "ORACLE",
        .synapse = "SYNAPSE",
        .sqlserver = "SQLSERVER",
        .db2 = "DB2",
        .opensearch = "OPENSEARCH",
        .bigquery = "BIGQUERY",
        .googlecloudstorage = "GOOGLECLOUDSTORAGE",
        .hbase = "HBASE",
        .documentdb = "DOCUMENTDB",
        .cmdb = "CMDB",
        .tpcds = "TPCDS",
        .timestream = "TIMESTREAM",
        .saphana = "SAPHANA",
        .snowflake = "SNOWFLAKE",
        .datalakegen2 = "DATALAKEGEN2",
        .db2_as400 = "DB2AS400",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dynamodb => "DYNAMODB",
            .mysql => "MYSQL",
            .postgresql => "POSTGRESQL",
            .redshift => "REDSHIFT",
            .oracle => "ORACLE",
            .synapse => "SYNAPSE",
            .sqlserver => "SQLSERVER",
            .db2 => "DB2",
            .opensearch => "OPENSEARCH",
            .bigquery => "BIGQUERY",
            .googlecloudstorage => "GOOGLECLOUDSTORAGE",
            .hbase => "HBASE",
            .documentdb => "DOCUMENTDB",
            .cmdb => "CMDB",
            .tpcds => "TPCDS",
            .timestream => "TIMESTREAM",
            .saphana => "SAPHANA",
            .snowflake => "SNOWFLAKE",
            .datalakegen2 => "DATALAKEGEN2",
            .db2_as400 => "DB2AS400",
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
