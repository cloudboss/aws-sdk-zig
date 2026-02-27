/// Template bundle S3 bucket data.
pub const S3ObjectSource = struct {
    /// The name of the S3 bucket that contains a template bundle.
    bucket: []const u8,

    /// The path to the S3 bucket that contains a template bundle.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
    };
};
