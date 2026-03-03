const std = @import("std");

pub const ConnectionType = enum {
    athena,
    bigquery,
    databricks,
    documentdb,
    dynamodb,
    hyperpod,
    iam,
    mysql,
    opensearch,
    oracle,
    postgresql,
    redshift,
    s3,
    saphana,
    snowflake,
    spark,
    sqlserver,
    teradata,
    vertica,
    workflows_mwaa,
    amazon_q,
    mlflow,

    pub const json_field_names = .{
        .athena = "ATHENA",
        .bigquery = "BIGQUERY",
        .databricks = "DATABRICKS",
        .documentdb = "DOCUMENTDB",
        .dynamodb = "DYNAMODB",
        .hyperpod = "HYPERPOD",
        .iam = "IAM",
        .mysql = "MYSQL",
        .opensearch = "OPENSEARCH",
        .oracle = "ORACLE",
        .postgresql = "POSTGRESQL",
        .redshift = "REDSHIFT",
        .s3 = "S3",
        .saphana = "SAPHANA",
        .snowflake = "SNOWFLAKE",
        .spark = "SPARK",
        .sqlserver = "SQLSERVER",
        .teradata = "TERADATA",
        .vertica = "VERTICA",
        .workflows_mwaa = "WORKFLOWS_MWAA",
        .amazon_q = "AMAZON_Q",
        .mlflow = "MLFLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .athena => "ATHENA",
            .bigquery => "BIGQUERY",
            .databricks => "DATABRICKS",
            .documentdb => "DOCUMENTDB",
            .dynamodb => "DYNAMODB",
            .hyperpod => "HYPERPOD",
            .iam => "IAM",
            .mysql => "MYSQL",
            .opensearch => "OPENSEARCH",
            .oracle => "ORACLE",
            .postgresql => "POSTGRESQL",
            .redshift => "REDSHIFT",
            .s3 => "S3",
            .saphana => "SAPHANA",
            .snowflake => "SNOWFLAKE",
            .spark => "SPARK",
            .sqlserver => "SQLSERVER",
            .teradata => "TERADATA",
            .vertica => "VERTICA",
            .workflows_mwaa => "WORKFLOWS_MWAA",
            .amazon_q => "AMAZON_Q",
            .mlflow => "MLFLOW",
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
