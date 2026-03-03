const ReportDestination = @import("report_destination.zig").ReportDestination;
const ObjectVersionIds = @import("object_version_ids.zig").ObjectVersionIds;
const ReportOutputType = @import("report_output_type.zig").ReportOutputType;
const ReportOverrides = @import("report_overrides.zig").ReportOverrides;
const ReportLevel = @import("report_level.zig").ReportLevel;

/// Specifies how you want to configure a task report, which provides detailed
/// information
/// about for your DataSync transfer.
///
/// For more information, see [Task
/// reports](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
pub const TaskReportConfig = struct {
    /// Specifies the Amazon S3 bucket where DataSync uploads your task report.
    /// For more information, see [Task
    /// reports](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html#task-report-access).
    destination: ?ReportDestination = null,

    /// Specifies whether your task report includes the new version of each object
    /// transferred
    /// into an S3 bucket. This only applies if you [enable versioning on your
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/manage-versioning-examples.html). Keep in mind that setting this to `INCLUDE` can increase the
    /// duration of your task execution.
    object_version_ids: ?ObjectVersionIds = null,

    /// Specifies the type of task report that you want:
    ///
    /// * `SUMMARY_ONLY`: Provides necessary details about your task, including the
    /// number of files, objects, and directories transferred and transfer duration.
    ///
    /// * `STANDARD`: Provides complete details about your task, including a full
    /// list of files, objects, and directories that were transferred, skipped,
    /// verified, and
    /// more.
    output_type: ?ReportOutputType = null,

    /// Customizes the reporting level for aspects of your task report. For example,
    /// your report
    /// might generally only include errors, but you could specify that you want a
    /// list of successes
    /// and errors just for the files that DataSync attempted to delete in your
    /// destination
    /// location.
    overrides: ?ReportOverrides = null,

    /// Specifies whether you want your task report to include only what went wrong
    /// with your
    /// transfer or a list of what succeeded and didn't.
    ///
    /// * `ERRORS_ONLY`: A report shows what DataSync was unable to
    /// transfer, skip, verify, and delete.
    ///
    /// * `SUCCESSES_AND_ERRORS`: A report shows what DataSync was able and
    /// unable to transfer, skip, verify, and delete.
    report_level: ?ReportLevel = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .object_version_ids = "ObjectVersionIds",
        .output_type = "OutputType",
        .overrides = "Overrides",
        .report_level = "ReportLevel",
    };
};
