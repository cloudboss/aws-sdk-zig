const ReportDestinationS3 = @import("report_destination_s3.zig").ReportDestinationS3;

/// Specifies where DataSync uploads your [task
/// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
pub const ReportDestination = struct {
    /// Specifies the Amazon S3 bucket where DataSync uploads your task
    /// report.
    s3: ?ReportDestinationS3 = null,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};
