pub const RecommendedRemediationAction = enum {
    create_policy,
    detach_policy,

    pub const json_field_names = .{
        .create_policy = "CREATE_POLICY",
        .detach_policy = "DETACH_POLICY",
    };
};
