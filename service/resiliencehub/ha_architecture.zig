pub const HaArchitecture = enum {
    multi_site,
    warm_standby,
    pilot_light,
    backup_and_restore,
    no_recovery_plan,

    pub const json_field_names = .{
        .multi_site = "MULTI_SITE",
        .warm_standby = "WARM_STANDBY",
        .pilot_light = "PILOT_LIGHT",
        .backup_and_restore = "BACKUP_AND_RESTORE",
        .no_recovery_plan = "NO_RECOVERY_PLAN",
    };
};
