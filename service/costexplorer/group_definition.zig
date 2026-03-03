const GroupDefinitionType = @import("group_definition_type.zig").GroupDefinitionType;

/// Represents a group when you specify a group by criteria or in the response
/// to a query
/// with a specific grouping.
pub const GroupDefinition = struct {
    /// The string that represents a key for a specified group.
    key: ?[]const u8 = null,

    /// The string that represents the type of group.
    @"type": ?GroupDefinitionType = null,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
    };
};
