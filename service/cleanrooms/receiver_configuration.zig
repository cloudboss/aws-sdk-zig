const AnalysisType = @import("analysis_type.zig").AnalysisType;
const ConfigurationDetails = @import("configuration_details.zig").ConfigurationDetails;

/// The receiver configuration for a protected query.
pub const ReceiverConfiguration = struct {
    /// The type of analysis for the protected query. The results of the query can
    /// be analyzed directly (`DIRECT_ANALYSIS`) or used as input into additional
    /// analyses (`ADDITIONAL_ANALYSIS`), such as a query that is a seed for a
    /// lookalike ML model.
    analysis_type: AnalysisType,

    /// The configuration details of the receiver configuration.
    configuration_details: ?ConfigurationDetails = null,

    pub const json_field_names = .{
        .analysis_type = "analysisType",
        .configuration_details = "configurationDetails",
    };
};
