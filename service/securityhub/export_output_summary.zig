const FindingsOutputSummary = @import("findings_output_summary.zig").FindingsOutputSummary;

/// A summary of the output configuration for an export job. The populated
/// member corresponds to the data type that was exported.
pub const ExportOutputSummary = union(enum) {
    /// The output configuration summary for a findings export.
    findings: ?FindingsOutputSummary,

    pub const json_field_names = .{
        .findings = "Findings",
    };
};
