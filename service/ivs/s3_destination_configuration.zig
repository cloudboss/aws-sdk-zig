/// A complex type that describes an S3 location where recorded videos will be
/// stored.
pub const S3DestinationConfiguration = struct {
    /// Location (S3 bucket name) where recorded videos will be stored.
    bucket_name: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
    };
};
