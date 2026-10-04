const AnalysisLogExportS3OutputConfiguration = @import("analysis_log_export_s3_output_configuration.zig").AnalysisLogExportS3OutputConfiguration;

/// Contains configuration details for analysis log export output.
pub const AnalysisLogExportOutputConfiguration = struct {
    /// Required configuration for an analysis log export with an `s3` output type.
    s_3: AnalysisLogExportS3OutputConfiguration,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
