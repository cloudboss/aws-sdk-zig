const SnowflakeNodeData = @import("snowflake_node_data.zig").SnowflakeNodeData;

/// Specifies a Snowflake target.
pub const SnowflakeTarget = struct {
    /// Specifies the data of the Snowflake target node.
    data: SnowflakeNodeData,

    /// The nodes that are inputs to the data target.
    inputs: ?[]const []const u8 = null,

    /// The name of the Snowflake target.
    name: []const u8,

    pub const json_field_names = .{
        .data = "Data",
        .inputs = "Inputs",
        .name = "Name",
    };
};
