const ExportDataType = @import("export_data_type.zig").ExportDataType;
const ExportDestination = @import("export_destination.zig").ExportDestination;
const ExportFailureCode = @import("export_failure_code.zig").ExportFailureCode;
const ExportOutputSummary = @import("export_output_summary.zig").ExportOutputSummary;
const ExportScopes = @import("export_scopes.zig").ExportScopes;
const ExportStatus = @import("export_status.zig").ExportStatus;

/// A summary of an export job, as returned by `ListExportJobsV2`.
pub const ExportSummary = struct {
    /// The category of data that the export job produces.
    data_type: ExportDataType,

    /// The destination that the export job writes to.
    destination: ExportDestination,

    /// The time when the export job reached a terminal state. Absent while the job
    /// is `RUNNING`.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ended_at: ?i64 = null,

    /// The unique identifier of the export job.
    export_job_id: []const u8,

    /// A code that classifies why the export job failed. Present only when `Status`
    /// is `FAILED`.
    failure_code: ?ExportFailureCode = null,

    /// A human-readable message about why the export job failed. Present only when
    /// `Status` is `FAILED`.
    failure_message: ?[]const u8 = null,

    /// The user-provided name of the export job, if one was specified.
    name: ?[]const u8 = null,

    /// The output configuration of the export job. For findings exports, this
    /// reports the output format. Present only for findings exports; absent for
    /// other data types.
    output_configuration: ?ExportOutputSummary = null,

    /// The organization scopes that the export job was started with, echoed
    /// verbatim. Absent if the caller didn't supply `Scopes`.
    scopes: ?ExportScopes = null,

    /// The time when the export job was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    started_at: i64,

    /// The current state of the export job.
    status: ExportStatus,

    pub const json_field_names = .{
        .data_type = "DataType",
        .destination = "Destination",
        .ended_at = "EndedAt",
        .export_job_id = "ExportJobId",
        .failure_code = "FailureCode",
        .failure_message = "FailureMessage",
        .name = "Name",
        .output_configuration = "OutputConfiguration",
        .scopes = "Scopes",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
