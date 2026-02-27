/// The Snowflake table schema.
pub const SnowflakeTableSchemaV1 = struct {
    /// The column name.
    column_name: []const u8,

    /// The column's data type. Supported data types: `ARRAY`, `BIGINT`, `BOOLEAN`,
    /// `CHAR`, `DATE`, `DECIMAL`, `DOUBLE`, `DOUBLE PRECISION`, `FLOAT`, `FLOAT4`,
    /// `INT`, `INTEGER`, `MAP`, `NUMERIC`, `NUMBER`, `REAL`, `SMALLINT`, `STRING`,
    /// `TIMESTAMP`, `TIMESTAMP_LTZ`, `TIMESTAMP_NTZ`, `DATETIME`, `TINYINT`,
    /// `VARCHAR`, `TEXT`, `CHARACTER`.
    column_type: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .column_type = "columnType",
    };
};
