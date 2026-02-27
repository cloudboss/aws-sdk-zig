/// The type of the backup.
pub const BackupType = enum {
    automatic,
    user_initiated,
    aws_backup,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .user_initiated = "USER_INITIATED",
        .aws_backup = "AWS_BACKUP",
    };
};
