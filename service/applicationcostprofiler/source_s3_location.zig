const S3BucketRegion = @import("s3_bucket_region.zig").S3BucketRegion;

/// Represents the Amazon Simple Storage Service (Amazon S3) location where
/// usage data is read
/// from.
pub const SourceS3Location = struct {
    /// Name of the bucket.
    bucket: []const u8,

    /// Key of the object.
    key: []const u8,

    /// Region of the bucket. Only required for Regions that are disabled by
    /// default.
    /// For more infomration about Regions that are disabled by default, see [
    /// Enabling a
    /// Region](https://docs.aws.amazon.com/general/latest/gr/rande-manage.html#rande-manage-enable) in the *AWS General Reference guide*.
    region: ?S3BucketRegion,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .region = "region",
    };
};
