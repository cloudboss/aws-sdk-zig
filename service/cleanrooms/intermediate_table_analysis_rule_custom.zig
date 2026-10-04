const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const AggregationThreshold = @import("aggregation_threshold.zig").AggregationThreshold;
const ComparisonControls = @import("comparison_controls.zig").ComparisonControls;
const DifferentialPrivacyConfiguration = @import("differential_privacy_configuration.zig").DifferentialPrivacyConfiguration;

/// Contains the custom analysis rule configuration for an intermediate table.
pub const IntermediateTableAnalysisRuleCustom = struct {
    /// The setting that controls whether additional analyses are allowed on the
    /// intermediate table.
    additional_analyses: ?AdditionalAnalyses = null,

    /// The aggregation thresholds that each query output group must satisfy. Clean
    /// Rooms filters out any group that represents fewer than the specified number
    /// of distinct identities. You can specify at most one threshold. You can't use
    /// aggregation thresholds with differential privacy, or when `allowedAnalyses`
    /// allows only jobs.
    aggregation_thresholds: ?[]const AggregationThreshold = null,

    /// The list of allowed additional analyses for the intermediate table.
    allowed_additional_analyses: ?[]const []const u8 = null,

    /// The list of allowed analyses that can be performed on the intermediate
    /// table.
    allowed_analyses: ?[]const []const u8 = null,

    /// The list of Amazon Web Services account IDs for the allowed analysis
    /// providers.
    allowed_analysis_providers: ?[]const []const u8 = null,

    /// The list of Amazon Web Services account IDs that are allowed to receive
    /// results from queries run on the intermediate table.
    allowed_result_receivers: ?[]const []const u8 = null,

    /// The controls that restrict how a query can compare the columns in the
    /// intermediate table. You can't use comparison controls with differential
    /// privacy, or when `allowedAnalyses` allows only jobs.
    comparison_controls: ?ComparisonControls = null,

    differential_privacy: ?DifferentialPrivacyConfiguration = null,

    /// The list of columns that are not allowed in the query output.
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
