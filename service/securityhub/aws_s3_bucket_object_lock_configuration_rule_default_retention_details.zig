/// The default S3 Object Lock retention mode and period that you want to apply
/// to new objects placed in the specified Amazon S3 bucket.
pub const AwsS3BucketObjectLockConfigurationRuleDefaultRetentionDetails = struct {
    /// The number of days that you want to specify for the default retention
    /// period.
    days: ?i32,

    /// The default Object Lock retention mode you want to apply to new objects
    /// placed in the specified bucket.
    mode: ?[]const u8,

    /// The number of years that you want to specify for the default retention
    /// period.
    years: ?i32,

    pub const json_field_names = .{
        .days = "Days",
        .mode = "Mode",
        .years = "Years",
    };
};
