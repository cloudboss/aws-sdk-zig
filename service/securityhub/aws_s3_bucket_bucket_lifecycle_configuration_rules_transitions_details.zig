/// A rule for when objects transition to specific storage classes.
pub const AwsS3BucketBucketLifecycleConfigurationRulesTransitionsDetails = struct {
    /// A date on which to transition objects to the specified storage class. If you
    /// provide `Date`, you cannot provide `Days`.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    date: ?[]const u8 = null,

    /// The number of days after which to transition the object to the specified
    /// storage class. If you provide `Days`, you cannot provide `Date`.
    days: ?i32 = null,

    /// The storage class to transition the object to. Valid values are as follows:
    ///
    /// * `DEEP_ARCHIVE`
    ///
    /// * `GLACIER`
    ///
    /// * `INTELLIGENT_TIERING`
    ///
    /// * `ONEZONE_IA`
    ///
    /// * `STANDARD_IA`
    storage_class: ?[]const u8 = null,

    pub const json_field_names = .{
        .date = "Date",
        .days = "Days",
        .storage_class = "StorageClass",
    };
};
