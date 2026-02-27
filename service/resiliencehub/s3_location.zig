/// The location of the Amazon S3 bucket.
pub const S3Location = struct {
    /// The name of the Amazon S3 bucket.
    bucket: ?[]const u8,

    /// The prefix for the Amazon S3 bucket.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
    };
};
