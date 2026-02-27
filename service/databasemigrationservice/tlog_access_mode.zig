pub const TlogAccessMode = enum {
    backup_only,
    prefer_backup,
    prefer_tlog,
    tlog_only,

    pub const json_field_names = .{
        .backup_only = "BackupOnly",
        .prefer_backup = "PreferBackup",
        .prefer_tlog = "PreferTlog",
        .tlog_only = "TlogOnly",
    };
};
