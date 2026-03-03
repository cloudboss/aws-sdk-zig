const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const DifferentialPrivacyConfiguration = @import("differential_privacy_configuration.zig").DifferentialPrivacyConfiguration;

/// Controls on the analysis specifications that can be run on a configured
/// table.
pub const ConsolidatedPolicyCustom = struct {
    /// Additional analyses for the consolidated policy.
    additional_analyses: ?AdditionalAnalyses = null,

    /// The additional analyses allowed by the consolidated policy.
    allowed_additional_analyses: ?[]const []const u8 = null,

    /// The allowed analyses.
    allowed_analyses: []const []const u8,

    /// The allowed analysis providers.
    allowed_analysis_providers: ?[]const []const u8 = null,

    /// The allowed result receivers.
    allowed_result_receivers: ?[]const []const u8 = null,

    differential_privacy: ?DifferentialPrivacyConfiguration = null,

    /// Disallowed output columns
    disallowed_output_columns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_analyses = "allowedAnalyses",
        .allowed_analysis_providers = "allowedAnalysisProviders",
        .allowed_result_receivers = "allowedResultReceivers",
        .differential_privacy = "differentialPrivacy",
        .disallowed_output_columns = "disallowedOutputColumns",
    };
};
