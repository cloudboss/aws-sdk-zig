pub const BackupType = enum {
    user,
    system,
    aws_backup,

    pub const json_field_names = .{
        .user = "USER",
        .system = "SYSTEM",
        .aws_backup = "AWS_BACKUP",
    };
};
