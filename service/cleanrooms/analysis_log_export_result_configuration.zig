const AnalysisLogExportOutputConfiguration = @import("analysis_log_export_output_configuration.zig").AnalysisLogExportOutputConfiguration;

/// Contains configurations for analysis log export results.
pub const AnalysisLogExportResultConfiguration = struct {
    /// The configuration for analysis log export results.
    output_configuration: AnalysisLogExportOutputConfiguration,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
    };
};
