/// Describes the location of updated firmware in S3.
pub const S3Destination = struct {
    /// The S3 bucket that contains the updated firmware.
    bucket: ?[]const u8 = null,

    /// The S3 prefix.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
    };
};
