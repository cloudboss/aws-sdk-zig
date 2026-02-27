const aws = @import("aws");

const S3ExpressDirectoryAccessPointConfiguration = @import("s3_express_directory_access_point_configuration.zig").S3ExpressDirectoryAccessPointConfiguration;

/// Proposed access control configuration for an Amazon S3 directory bucket. You
/// can propose a configuration for a new Amazon S3 directory bucket or an
/// existing Amazon S3 directory bucket that you own by specifying the Amazon S3
/// bucket policy. If the configuration is for an existing Amazon S3 directory
/// bucket and you do not specify the Amazon S3 bucket policy, the access
/// preview uses the existing policy attached to the directory bucket. If the
/// access preview is for a new resource and you do not specify the Amazon S3
/// bucket policy, the access preview assumes an directory bucket without a
/// policy. To propose deletion of an existing bucket policy, you can specify an
/// empty string. For more information about Amazon S3 directory bucket
/// policies, see [Example bucket policies for directory
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-example-bucket-policies.html) in the Amazon Simple Storage Service User Guide.
pub const S3ExpressDirectoryBucketConfiguration = struct {
    /// The proposed access points for the Amazon S3 directory bucket.
    access_points: ?[]const aws.map.MapEntry(S3ExpressDirectoryAccessPointConfiguration),

    /// The proposed bucket policy for the Amazon S3 directory bucket.
    bucket_policy: ?[]const u8,

    pub const json_field_names = .{
        .access_points = "accessPoints",
        .bucket_policy = "bucketPolicy",
    };
};
