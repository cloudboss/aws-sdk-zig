/// Information about what Amazon S3
/// does when a multipart upload is incomplete.
pub const AwsS3BucketBucketLifecycleConfigurationRulesAbortIncompleteMultipartUploadDetails = struct {
    /// The number of days after which Amazon S3 cancels an incomplete multipart
    /// upload.
    days_after_initiation: ?i32 = null,

    pub const json_field_names = .{
        .days_after_initiation = "DaysAfterInitiation",
    };
};
