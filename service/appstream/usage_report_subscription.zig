const UsageReportSchedule = @import("usage_report_schedule.zig").UsageReportSchedule;
const LastReportGenerationExecutionError = @import("last_report_generation_execution_error.zig").LastReportGenerationExecutionError;

/// Describes information about the usage report subscription.
pub const UsageReportSubscription = struct {
    /// The time when the last usage report was generated.
    last_generated_report_date: ?i64 = null,

    /// The Amazon S3 bucket where generated reports are stored.
    ///
    /// If you enabled on-instance session scripts and Amazon S3 logging for your
    /// session script
    /// configuration, WorkSpaces Applications created an S3 bucket to store the
    /// script output. The bucket is
    /// unique to your account and Region. When you enable usage reporting in this
    /// case, WorkSpaces Applications
    /// uses the same bucket to store your usage reports. If you haven't already
    /// enabled on-instance session scripts,
    /// when you enable usage reports, WorkSpaces Applications creates a new S3
    /// bucket.
    s3_bucket_name: ?[]const u8 = null,

    /// The schedule for generating usage reports.
    schedule: ?UsageReportSchedule = null,

    /// The errors that were returned if usage reports couldn't be generated.
    subscription_errors: ?[]const LastReportGenerationExecutionError = null,

    pub const json_field_names = .{
        .last_generated_report_date = "LastGeneratedReportDate",
        .s3_bucket_name = "S3BucketName",
        .schedule = "Schedule",
        .subscription_errors = "SubscriptionErrors",
    };
};
