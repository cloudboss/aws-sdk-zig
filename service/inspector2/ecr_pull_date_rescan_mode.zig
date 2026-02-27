pub const EcrPullDateRescanMode = enum {
    last_pull_date,
    last_in_use_at,

    pub const json_field_names = .{
        .last_pull_date = "LAST_PULL_DATE",
        .last_in_use_at = "LAST_IN_USE_AT",
    };
};
