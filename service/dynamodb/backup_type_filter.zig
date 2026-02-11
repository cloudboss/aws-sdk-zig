pub const BackupTypeFilter = enum {
    user,
    system,
    aws_backup,
    all,

    pub const json_field_names = .{
        .user = "USER",
        .system = "SYSTEM",
        .aws_backup = "AWS_BACKUP",
        .all = "ALL",
    };
};
