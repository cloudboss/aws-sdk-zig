/// A location in Amazon Simple Storage Service (Amazon S3) where SimSpace
/// Weaver stores simulation data, such as your app .zip
/// files and schema file. For more information about Amazon S3, see the [
/// *Amazon Simple Storage Service User Guide*
/// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html).
pub const S3Location = struct {
    /// The name of an Amazon S3 bucket. For more information about buckets, see
    /// [Creating,
    /// configuring, and working with Amazon S3
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-buckets-s3.html) in the *Amazon Simple Storage Service User
    /// Guide*.
    bucket_name: []const u8,

    /// The key name of an object in Amazon S3. For more information about Amazon S3
    /// objects and object
    /// keys, see [Uploading,
    /// downloading, and working with objects in Amazon
    /// S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/uploading-downloading-objects.html) in the *Amazon Simple Storage Service User
    /// Guide*.
    object_key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
    };
};
