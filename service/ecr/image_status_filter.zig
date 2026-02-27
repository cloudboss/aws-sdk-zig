pub const ImageStatusFilter = enum {
    active,
    archived,
    activating,
    any,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
        .activating = "ACTIVATING",
        .any = "ANY",
    };
};
