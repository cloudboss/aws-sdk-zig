const ParentEntityUpdateType = @import("parent_entity_update_type.zig").ParentEntityUpdateType;

/// The parent entity update request.
pub const ParentEntityUpdateRequest = struct {
    /// The ID of the parent entity.
    parent_entity_id: ?[]const u8,

    /// The type of the update.
    update_type: ParentEntityUpdateType,

    pub const json_field_names = .{
        .parent_entity_id = "parentEntityId",
        .update_type = "updateType",
    };
};
