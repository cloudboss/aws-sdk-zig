/// In terms of implementation, a Bucket is a resource.
pub const Bucket = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket. ARNs uniquely identify
    /// Amazon Web Services resources across all
    /// of Amazon Web Services.
    ///
    /// **Note:**
    ///
    /// This parameter is only supported for S3 directory buckets. For more
    /// information, see [Using tags with
    /// directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html).
    bucket_arn: ?[]const u8,

    /// `BucketRegion` indicates the Amazon Web Services region where the bucket is
    /// located. If the request
    /// contains at least one valid parameter, it is included in the response.
    bucket_region: ?[]const u8,

    /// Date the bucket was created. This date can change when making changes to
    /// your bucket, such as
    /// editing its bucket policy.
    creation_date: ?i64,

    /// The name of the bucket.
    name: ?[]const u8,
};
