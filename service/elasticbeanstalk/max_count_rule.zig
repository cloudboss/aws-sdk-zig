/// A lifecycle rule that deletes the oldest application version when the
/// maximum count is
/// exceeded.
pub const MaxCountRule = struct {
    /// Set to `true` to delete a version's source bundle from Amazon S3 when
    /// Elastic Beanstalk deletes the application version.
    delete_source_from_s3: ?bool = null,

    /// Specify `true` to apply the rule, or `false` to disable
    /// it.
    enabled: bool,

    /// Specify the maximum number of application versions to retain.
    max_count: ?i32 = null,
};
