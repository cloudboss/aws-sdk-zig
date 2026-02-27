pub const DeploymentHistoryFilter = enum {
    all,
    latest_only,

    pub const json_field_names = .{
        .all = "ALL",
        .latest_only = "LATEST_ONLY",
    };
};
