const Status = @import("status.zig").Status;

/// An object that contains information about an entity.
pub const EntitySummary = struct {
    /// The ARN of the entity.
    arn: []const u8,

    /// The date and time when the entity was created.
    creation_date_time: i64,

    /// The description of the entity.
    description: ?[]const u8 = null,

    /// The ID of the entity.
    entity_id: []const u8,

    /// The name of the entity.
    entity_name: []const u8,

    /// An **eventual** Boolean value that specifies whether the entity has child
    /// entities or not.
    has_child_entities: ?bool = null,

    /// The ID of the parent entity.
    parent_entity_id: ?[]const u8 = null,

    /// The current status of the entity.
    status: Status,

    /// The last date and time when the entity was updated.
    update_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .entity_id = "entityId",
        .entity_name = "entityName",
        .has_child_entities = "hasChildEntities",
        .parent_entity_id = "parentEntityId",
        .status = "status",
        .update_date_time = "updateDateTime",
    };
};
