const ProtectedJobAnalysisType = @import("protected_job_analysis_type.zig").ProtectedJobAnalysisType;
const ProtectedJobConfigurationDetails = @import("protected_job_configuration_details.zig").ProtectedJobConfigurationDetails;

/// The protected job receiver configuration.
pub const ProtectedJobReceiverConfiguration = struct {
    /// The analysis type for the protected job receiver configuration.
    analysis_type: ProtectedJobAnalysisType,

    /// The configuration details for the protected job receiver.
    configuration_details: ?ProtectedJobConfigurationDetails = null,

    pub const json_field_names = .{
        .analysis_type = "analysisType",
        .configuration_details = "configurationDetails",
    };
};
