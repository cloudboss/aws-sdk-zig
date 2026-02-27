const DirectAnalysisConfigurationDetails = @import("direct_analysis_configuration_details.zig").DirectAnalysisConfigurationDetails;

/// The configuration details.
pub const ConfigurationDetails = union(enum) {
    /// The direct analysis configuration details.
    direct_analysis_configuration_details: ?DirectAnalysisConfigurationDetails,

    pub const json_field_names = .{
        .direct_analysis_configuration_details = "directAnalysisConfigurationDetails",
    };
};
