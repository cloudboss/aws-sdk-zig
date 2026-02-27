/// A transition rule that describes when noncurrent objects transition to a
/// specified storage class.
pub const AwsS3BucketBucketLifecycleConfigurationRulesNoncurrentVersionTransitionsDetails = struct {
    /// The number of days that an object is noncurrent before Amazon S3 can perform
    /// the associated action.
    days: ?i32,

    /// The class of storage to change the object to after the object is noncurrent
    /// for the specified number of days.
    storage_class: ?[]const u8,

    pub const json_field_names = .{
        .days = "Days",
        .storage_class = "StorageClass",
    };
};
