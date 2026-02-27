pub const VaultType = enum {
    backup_vault,
    logically_air_gapped_backup_vault,
    restore_access_backup_vault,

    pub const json_field_names = .{
        .backup_vault = "BACKUP_VAULT",
        .logically_air_gapped_backup_vault = "LOGICALLY_AIR_GAPPED_BACKUP_VAULT",
        .restore_access_backup_vault = "RESTORE_ACCESS_BACKUP_VAULT",
    };
};
