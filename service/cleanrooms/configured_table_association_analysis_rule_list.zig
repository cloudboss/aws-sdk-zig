/// The configured table association analysis rule applied to a configured table
/// with the list analysis rule.
pub const ConfiguredTableAssociationAnalysisRuleList = struct {
    /// The list of resources or wildcards (ARNs) that are allowed to perform
    /// additional analysis on query output.
    allowed_additional_analyses: ?[]const []const u8,

    /// The list of collaboration members who are allowed to receive results of
    /// queries run with this configured table.
    allowed_result_receivers: ?[]const []const u8,

    pub const json_field_names = .{
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_result_receivers = "allowedResultReceivers",
    };
};
