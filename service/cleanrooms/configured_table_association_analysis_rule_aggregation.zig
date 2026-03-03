/// The configured table association analysis rule applied to a configured table
/// with the aggregation analysis rule.
pub const ConfiguredTableAssociationAnalysisRuleAggregation = struct {
    /// The list of resources or wildcards (ARNs) that are allowed to perform
    /// additional analysis on query output.
    ///
    /// The `allowedAdditionalAnalyses` parameter is currently supported for the
    /// list analysis rule (`AnalysisRuleList`) and the custom analysis rule
    /// (`AnalysisRuleCustom`).
    allowed_additional_analyses: ?[]const []const u8 = null,

    /// The list of collaboration members who are allowed to receive results of
    /// queries run with this configured table.
    allowed_result_receivers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_result_receivers = "allowedResultReceivers",
    };
};
