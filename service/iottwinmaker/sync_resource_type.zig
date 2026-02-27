pub const SyncResourceType = enum {
    entity,
    component_type,

    pub const json_field_names = .{
        .entity = "ENTITY",
        .component_type = "COMPONENT_TYPE",
    };
};
