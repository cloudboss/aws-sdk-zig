pub const ShareResourceType = enum {
    workload,
    lens,
    profile,
    template,

    pub const json_field_names = .{
        .workload = "WORKLOAD",
        .lens = "LENS",
        .profile = "PROFILE",
        .template = "TEMPLATE",
    };
};
