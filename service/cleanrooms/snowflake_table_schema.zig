const SnowflakeTableSchemaV1 = @import("snowflake_table_schema_v1.zig").SnowflakeTableSchemaV1;

/// The schema of a Snowflake table.
pub const SnowflakeTableSchema = union(enum) {
    /// The schema of a Snowflake table.
    v_1: ?[]const SnowflakeTableSchemaV1,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
