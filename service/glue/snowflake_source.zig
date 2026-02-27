const SnowflakeNodeData = @import("snowflake_node_data.zig").SnowflakeNodeData;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a Snowflake data source.
pub const SnowflakeSource = struct {
    /// Configuration for the Snowflake data source.
    data: SnowflakeNodeData,

    /// The name of the Snowflake data source.
    name: []const u8,

    /// Specifies user-defined schemas for your output data.
    output_schemas: ?[]const GlueSchema,

    pub const json_field_names = .{
        .data = "Data",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
