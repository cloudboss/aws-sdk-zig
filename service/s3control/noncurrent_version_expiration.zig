/// The container of the noncurrent version expiration.
pub const NoncurrentVersionExpiration = struct {
    /// Specifies how many noncurrent versions S3 on Outposts will retain. If there
    /// are this many
    /// more recent noncurrent versions, S3 on Outposts will take the associated
    /// action. For more
    /// information about noncurrent versions, see [Lifecycle configuration
    /// elements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) in the *Amazon S3 User Guide*.
    newer_noncurrent_versions: ?i32,

    /// Specifies the number of days an object is noncurrent before Amazon S3 can
    /// perform the
    /// associated action. For information about the noncurrent days calculations,
    /// see [How
    /// Amazon S3 Calculates When an Object Became
    /// Noncurrent](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the
    /// *Amazon S3 User Guide*.
    noncurrent_days: i32 = 0,
};
