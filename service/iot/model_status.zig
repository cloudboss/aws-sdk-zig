pub const ModelStatus = enum {
    pending_build,
    active,
    expired,

    pub const json_field_names = .{
        .pending_build = "PENDING_BUILD",
        .active = "ACTIVE",
        .expired = "EXPIRED",
    };
};
