const ReportDestination = @import("report_destination.zig").ReportDestination;

/// Contains detailed information about a report job. A report job compiles a
/// report based
/// on a report plan and publishes it to Amazon S3.
pub const ReportJob = struct {
    /// The date and time that a report job is completed, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CompletionTime` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    completion_time: ?i64,

    /// The date and time that a report job is created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreationTime` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_time: ?i64,

    /// The S3 bucket name and S3 keys for the destination where the report job
    /// publishes the
    /// report.
    report_destination: ?ReportDestination,

    /// The identifier for a report job. A unique, randomly generated, Unicode,
    /// UTF-8 encoded
    /// string that is at most 1,024 bytes long. Report job IDs cannot be edited.
    report_job_id: ?[]const u8,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    report_plan_arn: ?[]const u8,

    /// Identifies the report template for the report. Reports are built using a
    /// report
    /// template. The report templates are:
    ///
    /// `RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT | BACKUP_JOB_REPORT
    /// |
    /// COPY_JOB_REPORT | RESTORE_JOB_REPORT`
    report_template: ?[]const u8,

    /// The status of a report job. The statuses are:
    ///
    /// `CREATED | RUNNING | COMPLETED | FAILED`
    ///
    /// `COMPLETED` means that the report is available for your review at your
    /// designated destination. If the status is `FAILED`, review the
    /// `StatusMessage` for the reason.
    status: ?[]const u8,

    /// A message explaining the status of the report job.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .report_destination = "ReportDestination",
        .report_job_id = "ReportJobId",
        .report_plan_arn = "ReportPlanArn",
        .report_template = "ReportTemplate",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
