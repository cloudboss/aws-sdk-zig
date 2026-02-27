const InputQueryType = @import("input_query_type.zig").InputQueryType;

/// Contains information about a natural language query to transform into SQL.
pub const QueryGenerationInput = struct {
    /// The text of the query.
    text: []const u8,

    /// The type of the query.
    @"type": InputQueryType,

    pub const json_field_names = .{
        .text = "text",
        .@"type" = "type",
    };
};
