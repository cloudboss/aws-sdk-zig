/// A lifecycle rule that deletes application versions after the specified
/// number of
/// days.
pub const MaxAgeRule = struct {
    /// Set to `true` to delete a version's source bundle from Amazon S3 when
    /// Elastic Beanstalk deletes the application version.
    delete_source_from_s3: ?bool,

    /// Specify `true` to apply the rule, or `false` to disable
    /// it.
    enabled: bool,

    /// Specify the number of days to retain an application versions.
    max_age_in_days: ?i32,
};
