pub const RetrieverStatus = enum {
    creating,
    active,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
