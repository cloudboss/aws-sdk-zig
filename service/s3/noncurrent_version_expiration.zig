/// Specifies when noncurrent object versions expire. Upon expiration, Amazon S3
/// permanently deletes the
/// noncurrent object versions. You set this lifecycle configuration action on a
/// bucket that has versioning
/// enabled (or suspended) to request that Amazon S3 delete noncurrent object
/// versions at a specific period in
/// the object's lifetime.
///
/// **Note:**
///
/// This parameter applies to general purpose buckets only. It is not supported
/// for directory bucket
/// lifecycle configurations.
pub const NoncurrentVersionExpiration = struct {
    /// Specifies how many noncurrent versions Amazon S3 will retain. You can
    /// specify up to 100 noncurrent
    /// versions to retain. Amazon S3 will permanently delete any additional
    /// noncurrent versions beyond the specified
    /// number to retain. For more information about noncurrent versions, see
    /// [Lifecycle configuration
    /// elements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// **Note:**
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    newer_noncurrent_versions: ?i32,

    /// Specifies the number of days an object is noncurrent before Amazon S3 can
    /// perform the associated action.
    /// The value must be a non-zero positive integer. For information about the
    /// noncurrent days calculations,
    /// see [How Amazon S3 Calculates
    /// When an Object Became
    /// Noncurrent](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the *Amazon S3 User Guide*.
    ///
    /// **Note:**
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    noncurrent_days: ?i32,
};
