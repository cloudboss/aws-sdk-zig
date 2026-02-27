/// The container for abort incomplete multipart upload
pub const AbortIncompleteMultipartUpload = struct {
    /// Specifies the number of days after which Amazon S3 aborts an incomplete
    /// multipart upload to
    /// the Outposts bucket.
    days_after_initiation: i32 = 0,
};
