const ExportStatus = @import("export_status.zig").ExportStatus;

/// Information regarding the export status of discovered data. The value is an
/// array of
/// objects.
pub const ExportInfo = struct {
    /// A URL for an Amazon S3 bucket where you can review the exported data. The
    /// URL is
    /// displayed only if the export succeeded.
    configurations_download_url: ?[]const u8 = null,

    /// A unique identifier used to query an export.
    export_id: []const u8,

    /// The time that the data export was initiated.
    export_request_time: i64,

    /// The status of the data export job.
    export_status: ExportStatus,

    /// If true, the export of agent information exceeded the size limit for a
    /// single export
    /// and the exported data is incomplete for the requested time range. To address
    /// this, select a
    /// smaller time range for the export by using `startDate` and
    /// `endDate`.
    is_truncated: bool = false,

    /// The `endTime` used in the `StartExportTask` request. If no
    /// `endTime` was requested, this result does not appear in
    /// `ExportInfo`.
    requested_end_time: ?i64 = null,

    /// The value of `startTime` parameter in the `StartExportTask`
    /// request. If no `startTime` was requested, this result does not appear in
    /// `ExportInfo`.
    requested_start_time: ?i64 = null,

    /// A status message provided for API callers.
    status_message: []const u8,

    pub const json_field_names = .{
        .configurations_download_url = "configurationsDownloadUrl",
        .export_id = "exportId",
        .export_request_time = "exportRequestTime",
        .export_status = "exportStatus",
        .is_truncated = "isTruncated",
        .requested_end_time = "requestedEndTime",
        .requested_start_time = "requestedStartTime",
        .status_message = "statusMessage",
    };
};
