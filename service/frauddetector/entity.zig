/// The entity details.
pub const Entity = struct {
    /// The entity ID. If you do not know the `entityId`, you can pass `unknown`,
    /// which is areserved string literal.
    entity_id: []const u8,

    /// The entity type.
    entity_type: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .entity_type = "entityType",
    };
};
