pub const CreateBucketResult = struct {
    /// The Amazon Resource Name (ARN) of the bucket.
    ///
    /// For using this parameter with Amazon S3 on Outposts with the REST API, you
    /// must specify the name and the x-amz-outpost-id as well.
    ///
    /// For using this parameter with S3 on Outposts with the Amazon Web Services
    /// SDK and CLI, you must specify the ARN of the bucket accessed in the format
    /// `arn:aws:s3-outposts:::outpost//bucket/`. For example, to access the bucket
    /// `reports` through Outpost `my-outpost` owned by account `123456789012` in
    /// Region `us-west-2`, use the URL encoding of
    /// `arn:aws:s3-outposts:us-west-2:123456789012:outpost/my-outpost/bucket/reports`. The value must be URL encoded.
    bucket_arn: ?[]const u8,

    /// The location of the bucket.
    location: ?[]const u8,
};
