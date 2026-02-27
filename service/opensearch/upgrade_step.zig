pub const UpgradeStep = enum {
    pre_upgrade_check,
    snapshot,
    upgrade,

    pub const json_field_names = .{
        .pre_upgrade_check = "PRE_UPGRADE_CHECK",
        .snapshot = "SNAPSHOT",
        .upgrade = "UPGRADE",
    };
};
