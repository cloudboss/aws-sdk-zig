/// Input for entities needed to be deleted
pub const DeleteEntitiesInfo = struct {
    entity_ids: []const []const u8,

    pub const json_field_names = .{
        .entity_ids = "entityIds",
    };
};
