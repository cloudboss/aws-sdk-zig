/// The Amazon S3 bucket location to which Amazon Rekognition publishes the
/// detailed inference results of a video analysis operation.
/// These results include the name of the stream processor resource, the session
/// ID of the stream processing session,
/// and labeled timestamps and bounding boxes for detected labels.
pub const S3Destination = struct {
    /// The name of the Amazon S3 bucket you want to associate with the streaming
    /// video project. You must be the owner of the Amazon S3 bucket.
    bucket: ?[]const u8,

    /// The prefix value of the location within the bucket that you want the
    /// information to be published to.
    /// For more information, see [Using
    /// prefixes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-prefixes.html).
    key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key_prefix = "KeyPrefix",
    };
};
