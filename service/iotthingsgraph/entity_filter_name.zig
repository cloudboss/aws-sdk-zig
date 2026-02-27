pub const EntityFilterName = enum {
    name,
    namespace,
    semantic_type_path,
    referenced_entity_id,

    pub const json_field_names = .{
        .name = "NAME",
        .namespace = "NAMESPACE",
        .semantic_type_path = "SEMANTIC_TYPE_PATH",
        .referenced_entity_id = "REFERENCED_ENTITY_ID",
    };
};
