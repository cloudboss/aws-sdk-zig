const ReportFormat = @import("report_format.zig").ReportFormat;
const ReportScope = @import("report_scope.zig").ReportScope;

/// Provides a report detailing the data repository task results of the files
/// processed that match the criteria specified in the report `Scope` parameter.
/// FSx delivers the report to the file system's linked data repository in
/// Amazon S3,
/// using the path specified in the report `Path` parameter.
/// You can specify whether or not a report gets generated for a task using the
/// `Enabled` parameter.
pub const CompletionReport = struct {
    /// Set `Enabled` to `True` to generate a `CompletionReport` when the task
    /// completes.
    /// If set to `true`, then you need to provide a report `Scope`, `Path`, and
    /// `Format`.
    /// Set `Enabled` to `False` if you do not want a `CompletionReport` generated
    /// when the task completes.
    enabled: bool,

    /// Required if `Enabled` is set to `true`. Specifies the format of the
    /// `CompletionReport`. `REPORT_CSV_20191124` is the only format currently
    /// supported.
    /// When `Format` is set to `REPORT_CSV_20191124`, the `CompletionReport` is
    /// provided in CSV format, and is delivered to
    /// `{path}/task-{id}/failures.csv`.
    format: ?ReportFormat = null,

    /// Required if `Enabled` is set to `true`. Specifies the location of the report
    /// on the file system's
    /// linked S3 data repository. An absolute path that defines where the
    /// completion report will be stored in the destination location.
    /// The `Path` you provide must be located within the file system’s ExportPath.
    /// An example `Path` value is
    /// "s3://amzn-s3-demo-bucket/myExportPath/optionalPrefix".
    /// The report provides the following information for each file in the report:
    /// FilePath, FileStatus, and ErrorCode.
    path: ?[]const u8 = null,

    /// Required if `Enabled` is set to `true`. Specifies the scope of the
    /// `CompletionReport`; `FAILED_FILES_ONLY` is the only scope currently
    /// supported.
    /// When `Scope` is set to `FAILED_FILES_ONLY`, the `CompletionReport` only
    /// contains information about files that the data repository task failed to
    /// process.
    scope: ?ReportScope = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .format = "Format",
        .path = "Path",
        .scope = "Scope",
    };
};
