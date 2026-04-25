const EntityType = @import("entity_type.zig").EntityType;

/// Information about an entity type in the DataAutomationLibrary
pub const EntityTypeInfo = struct {
    entity_metadata: ?[]const u8 = null,

    entity_type: EntityType,

    pub const json_field_names = .{
        .entity_metadata = "entityMetadata",
        .entity_type = "entityType",
    };
};
