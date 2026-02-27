const S3BucketConfiguration = @import("s3_bucket_configuration.zig").S3BucketConfiguration;

/// A structure that describes the Amazon S3 settings to use to save the
/// generated dashboard snapshot.
pub const SnapshotS3DestinationConfiguration = struct {
    /// A structure that contains details about the Amazon S3 bucket that the
    /// generated dashboard snapshot is saved in.
    bucket_configuration: S3BucketConfiguration,

    pub const json_field_names = .{
        .bucket_configuration = "BucketConfiguration",
    };
};
