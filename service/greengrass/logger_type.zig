pub const LoggerType = enum {
    file_system,
    aws_cloud_watch,

    pub const json_field_names = .{
        .file_system = "FileSystem",
        .aws_cloud_watch = "AWSCloudWatch",
    };
};
