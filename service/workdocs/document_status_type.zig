pub const DocumentStatusType = enum {
    initialized,
    active,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .active = "ACTIVE",
    };
};
