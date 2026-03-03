const RelationshipType = @import("relationship_type.zig").RelationshipType;

/// List of child blocks for the current block.
pub const RelationshipsListItem = struct {
    /// Identifers of the child blocks.
    ids: ?[]const []const u8 = null,

    /// Only supported relationship is a child relationship.
    @"type": ?RelationshipType = null,

    pub const json_field_names = .{
        .ids = "Ids",
        .@"type" = "Type",
    };
};
