const SnowflakeTableSchema = @import("snowflake_table_schema.zig").SnowflakeTableSchema;

/// A reference to a table within Snowflake.
pub const SnowflakeTableReference = struct {
    /// The account identifier for the Snowflake table reference.
    account_identifier: []const u8,

    /// The name of the database the Snowflake table belongs to.
    database_name: []const u8,

    /// The schema name of the Snowflake table reference.
    schema_name: []const u8,

    /// The secret ARN of the Snowflake table reference.
    secret_arn: []const u8,

    /// The name of the Snowflake table.
    table_name: []const u8,

    /// The schema of the Snowflake table.
    table_schema: SnowflakeTableSchema,

    pub const json_field_names = .{
        .account_identifier = "accountIdentifier",
        .database_name = "databaseName",
        .schema_name = "schemaName",
        .secret_arn = "secretArn",
        .table_name = "tableName",
        .table_schema = "tableSchema",
    };
};
