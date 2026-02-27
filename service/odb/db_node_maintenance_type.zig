pub const DbNodeMaintenanceType = enum {
    vmdb_reboot_migration,

    pub const json_field_names = .{
        .vmdb_reboot_migration = "VMDB_REBOOT_MIGRATION",
    };
};
