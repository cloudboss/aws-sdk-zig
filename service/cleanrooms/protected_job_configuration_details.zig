const ProtectedJobDirectAnalysisConfigurationDetails = @import("protected_job_direct_analysis_configuration_details.zig").ProtectedJobDirectAnalysisConfigurationDetails;

/// The protected job configuration details.
pub const ProtectedJobConfigurationDetails = union(enum) {
    /// The details needed to configure the direct analysis.
    direct_analysis_configuration_details: ?ProtectedJobDirectAnalysisConfigurationDetails,

    pub const json_field_names = .{
        .direct_analysis_configuration_details = "directAnalysisConfigurationDetails",
    };
};
