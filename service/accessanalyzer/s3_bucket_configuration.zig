const aws = @import("aws");

const S3AccessPointConfiguration = @import("s3_access_point_configuration.zig").S3AccessPointConfiguration;
const S3BucketAclGrantConfiguration = @import("s3_bucket_acl_grant_configuration.zig").S3BucketAclGrantConfiguration;
const S3PublicAccessBlockConfiguration = @import("s3_public_access_block_configuration.zig").S3PublicAccessBlockConfiguration;

/// Proposed access control configuration for an Amazon S3 bucket. You can
/// propose a configuration for a new Amazon S3 bucket or an existing Amazon S3
/// bucket that you own by specifying the Amazon S3 bucket policy, bucket ACLs,
/// bucket BPA settings, Amazon S3 access points, and multi-region access points
/// attached to the bucket. If the configuration is for an existing Amazon S3
/// bucket and you do not specify the Amazon S3 bucket policy, the access
/// preview uses the existing policy attached to the bucket. If the access
/// preview is for a new resource and you do not specify the Amazon S3 bucket
/// policy, the access preview assumes a bucket without a policy. To propose
/// deletion of an existing bucket policy, you can specify an empty string. For
/// more information about bucket policy limits, see [Bucket Policy
/// Examples](https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html).
pub const S3BucketConfiguration = struct {
    /// The configuration of Amazon S3 access points or multi-region access points
    /// for the bucket. You can propose up to 10 new access points per bucket.
    access_points: ?[]const aws.map.MapEntry(S3AccessPointConfiguration),

    /// The proposed list of ACL grants for the Amazon S3 bucket. You can propose up
    /// to 100 ACL grants per bucket. If the proposed grant configuration is for an
    /// existing bucket, the access preview uses the proposed list of grant
    /// configurations in place of the existing grants. Otherwise, the access
    /// preview uses the existing grants for the bucket.
    bucket_acl_grants: ?[]const S3BucketAclGrantConfiguration,

    /// The proposed bucket policy for the Amazon S3 bucket.
    bucket_policy: ?[]const u8,

    /// The proposed block public access configuration for the Amazon S3 bucket.
    bucket_public_access_block: ?S3PublicAccessBlockConfiguration,

    pub const json_field_names = .{
        .access_points = "accessPoints",
        .bucket_acl_grants = "bucketAclGrants",
        .bucket_policy = "bucketPolicy",
        .bucket_public_access_block = "bucketPublicAccessBlock",
    };
};
