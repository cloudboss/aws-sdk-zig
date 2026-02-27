/// If the project stores evaluation events in an Amazon S3 bucket, this
/// structure stores the bucket name and bucket prefix.
pub const S3DestinationConfig = struct {
    /// The name of the bucket in which Evidently stores evaluation events.
    bucket: ?[]const u8,

    /// The bucket prefix in which Evidently stores evaluation events.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
    };
};
