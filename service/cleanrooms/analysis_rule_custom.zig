const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const AggregationThreshold = @import("aggregation_threshold.zig").AggregationThreshold;
const ComparisonControls = @import("comparison_controls.zig").ComparisonControls;
const DifferentialPrivacyConfiguration = @import("differential_privacy_configuration.zig").DifferentialPrivacyConfiguration;

/// A type of analysis rule that enables the table owner to approve custom SQL
/// queries on their configured tables. It supports differential privacy,
/// minimum aggregation thresholds, and comparison controls.
pub const AnalysisRuleCustom = struct {
    /// An indicator as to whether additional analyses (such as Clean Rooms ML) can
    /// be applied to the output of the direct query.
    additional_analyses: ?AdditionalAnalyses = null,

    /// The aggregation thresholds that each query output group must satisfy. Clean
    /// Rooms filters out any group that represents fewer than the specified number
    /// of distinct identities. You can specify at most one threshold. You can't use
    /// aggregation thresholds with differential privacy, or when `allowedAnalyses`
    /// allows only jobs.
    aggregation_thresholds: ?[]const AggregationThreshold = null,

    /// The list of allowed additional analyses for the custom analysis rule.
    allowed_additional_analyses: ?[]const []const u8 = null,

    /// The ARN of the analysis templates that are allowed by the custom analysis
    /// rule.
    allowed_analyses: []const []const u8,

    /// The IDs of the Amazon Web Services accounts that are allowed to query by the
    /// custom analysis rule. Required when `allowedAnalyses` is `ANY_QUERY`.
    allowed_analysis_providers: ?[]const []const u8 = null,

    /// The list of Amazon Web Services account IDs that are allowed to receive
    /// results from queries run on the configured table.
    allowed_result_receivers: ?[]const []const u8 = null,

    /// The controls that restrict how a query can compare the columns in the
    /// configured table. You can't use comparison controls with differential
    /// privacy, or when `allowedAnalyses` allows only jobs.
    comparison_controls: ?ComparisonControls = null,

    /// The differential privacy configuration.
    differential_privacy: ?DifferentialPrivacyConfiguration = null,

    /// A list of columns that aren't allowed to be shown in the query output.
    disallowed_output_columns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .aggregation_thresholds = "aggregationThresholds",
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_analyses = "allowedAnalyses",
        .allowed_analysis_providers = "allowedAnalysisProviders",
        .allowed_result_receivers = "allowedResultReceivers",
        .comparison_controls = "comparisonControls",
        .differential_privacy = "differentialPrivacy",
        .disallowed_output_columns = "disallowedOutputColumns",
    };
};
