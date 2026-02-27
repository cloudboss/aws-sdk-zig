pub const BackintMode = enum {
    aws_backup,

    pub const json_field_names = .{
        .aws_backup = "AWSBackup",
    };
};
