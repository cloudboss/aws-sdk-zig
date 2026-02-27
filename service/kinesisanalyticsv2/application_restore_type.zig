pub const ApplicationRestoreType = enum {
    skip_restore_from_snapshot,
    restore_from_latest_snapshot,
    restore_from_custom_snapshot,

    pub const json_field_names = .{
        .skip_restore_from_snapshot = "SKIP_RESTORE_FROM_SNAPSHOT",
        .restore_from_latest_snapshot = "RESTORE_FROM_LATEST_SNAPSHOT",
        .restore_from_custom_snapshot = "RESTORE_FROM_CUSTOM_SNAPSHOT",
    };
};
