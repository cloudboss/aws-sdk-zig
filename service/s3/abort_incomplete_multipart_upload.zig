/// Specifies the days since the initiation of an incomplete multipart upload
/// that Amazon S3 will wait before
/// permanently removing all parts of the upload. For more information, see [
/// Aborting
/// Incomplete Multipart Uploads Using a Bucket Lifecycle
/// Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the
/// *Amazon S3 User Guide*.
pub const AbortIncompleteMultipartUpload = struct {
    /// Specifies the number of days after which Amazon S3 aborts an incomplete
    /// multipart upload.
    days_after_initiation: ?i32,
};
