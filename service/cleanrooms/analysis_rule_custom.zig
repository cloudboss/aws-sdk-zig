const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const DifferentialPrivacyConfiguration = @import("differential_privacy_configuration.zig").DifferentialPrivacyConfiguration;

/// A type of analysis rule that enables the table owner to approve custom SQL
/// queries on their configured tables. It supports differential privacy.
pub const AnalysisRuleCustom = struct {
    /// An indicator as to whether additional analyses (such as Clean Rooms ML) can
    /// be applied to the output of the direct query.
    additional_analyses: ?AdditionalAnalyses = null,

    /// The ARN of the analysis templates that are allowed by the custom analysis
    /// rule.
    allowed_analyses: []const []const u8,

    /// The IDs of the Amazon Web Services accounts that are allowed to query by the
    /// custom analysis rule. Required when `allowedAnalyses` is `ANY_QUERY`.
    allowed_analysis_providers: ?[]const []const u8 = null,

    /// The differential privacy configuration.
    differential_privacy: ?DifferentialPrivacyConfiguration = null,

    /// A list of columns that aren't allowed to be shown in the query output.
    disallowed_output_columns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .allowed_analyses = "allowedAnalyses",
        .allowed_analysis_providers = "allowedAnalysisProviders",
        .differential_privacy = "differentialPrivacy",
        .disallowed_output_columns = "disallowedOutputColumns",
    };
};
