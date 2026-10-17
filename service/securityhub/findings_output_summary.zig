const FindingsExportFormat = @import("findings_export_format.zig").FindingsExportFormat;

/// A summary of the output configuration for a findings export, returned by
/// `ListExportJobsV2`. Unlike the configuration returned by `GetExportJobV2`,
/// it reports only the output format.
pub const FindingsOutputSummary = struct {
    /// The output format of the export. `CSV` produces comma-separated rows that
    /// are suitable for spreadsheets and analysis tools. `OCSF_JSON` produces
    /// newline-delimited JSON records in the Open Cybersecurity Schema Framework
    /// (OCSF) format used elsewhere in Security Hub.
    format: FindingsExportFormat,

    pub const json_field_names = .{
        .format = "Format",
    };
};
