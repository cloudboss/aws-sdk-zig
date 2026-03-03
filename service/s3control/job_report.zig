const JobReportFormat = @import("job_report_format.zig").JobReportFormat;
const JobReportScope = @import("job_report_scope.zig").JobReportScope;

/// Contains the configuration parameters for a job-completion report.
pub const JobReport = struct {
    /// The Amazon Resource Name (ARN) for the bucket where specified job-completion
    /// report will
    /// be stored.
    ///
    /// **Directory buckets** - Directory buckets aren't supported
    /// as a location for Batch Operations to store job completion reports.
    bucket: ?[]const u8 = null,

    /// Indicates whether the specified job will generate a job-completion report.
    enabled: bool = false,

    /// Lists the Amazon Web Services account ID that owns the target bucket, where
    /// the completion report is received.
    expected_bucket_owner: ?[]const u8 = null,

    /// The format of the specified job-completion report.
    format: ?JobReportFormat = null,

    /// An optional prefix to describe where in the specified bucket the
    /// job-completion report
    /// will be stored. Amazon S3 stores the job-completion report at
    /// `/job-/report.json`.
    prefix: ?[]const u8 = null,

    /// Indicates whether the job-completion report will include details of all
    /// tasks or only
    /// failed tasks.
    report_scope: ?JobReportScope = null,
};
