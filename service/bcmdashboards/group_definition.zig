const GroupDefinitionType = @import("group_definition_type.zig").GroupDefinitionType;

/// Specifies how to group cost and usage data.
pub const GroupDefinition = struct {
    /// The key to use for grouping cost and usage data.
    key: []const u8,

    /// The type of grouping to apply.
    type: GroupDefinitionType = "DIMENSION",

    pub const json_field_names = .{
        .key = "key",
        .type = "type",
    };
};
