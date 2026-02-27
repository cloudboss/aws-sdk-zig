pub const TieringPolicyName = enum {
    snapshot_only,
    auto,
    all,
    none,

    pub const json_field_names = .{
        .snapshot_only = "SNAPSHOT_ONLY",
        .auto = "AUTO",
        .all = "ALL",
        .none = "NONE",
    };
};
