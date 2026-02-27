pub const FoundationModelLifecycleStatus = enum {
    active,
    legacy,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .legacy = "LEGACY",
    };
};
