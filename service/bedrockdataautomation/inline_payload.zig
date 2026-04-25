const DeleteEntitiesInfo = @import("delete_entities_info.zig").DeleteEntitiesInfo;
const UpsertEntityInfo = @import("upsert_entity_info.zig").UpsertEntityInfo;

/// Input payload structure definition
pub const InlinePayload = union(enum) {
    delete_entities_info: ?DeleteEntitiesInfo,
    upsert_entities_info: ?[]const UpsertEntityInfo,

    pub const json_field_names = .{
        .delete_entities_info = "deleteEntitiesInfo",
        .upsert_entities_info = "upsertEntitiesInfo",
    };
};
