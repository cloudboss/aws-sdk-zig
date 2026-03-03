pub const S3 = struct {
    bucket: ?[]const u8 = null,

    enabled: bool,

    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .enabled = "Enabled",
        .prefix = "Prefix",
    };
};
