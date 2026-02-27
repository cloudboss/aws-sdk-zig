pub const RepoUpgradeOnBoot = enum {
    security,
    none,

    pub const json_field_names = .{
        .security = "SECURITY",
        .none = "NONE",
    };
};
