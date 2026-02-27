pub const ModelStatus = enum {
    active,
    creating,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .failed = "FAILED",
    };
};
