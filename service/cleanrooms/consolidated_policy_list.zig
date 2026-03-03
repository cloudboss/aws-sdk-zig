const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const JoinOperator = @import("join_operator.zig").JoinOperator;

/// Controls on the analysis specifications that can be run on a configured
/// table.
pub const ConsolidatedPolicyList = struct {
    /// Additional analyses for the consolidated policy list.
    additional_analyses: ?AdditionalAnalyses = null,

    /// The additional analyses allowed by the consolidated policy list.
    allowed_additional_analyses: ?[]const []const u8 = null,

    /// The allowed join operators in the consolidated policy list.
    allowed_join_operators: ?[]const JoinOperator = null,

    /// The allowed result receivers.
    allowed_result_receivers: ?[]const []const u8 = null,

    /// The columns to join on.
    join_columns: []const []const u8,

    /// The columns in the consolidated policy list.
    list_columns: []const []const u8,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_join_operators = "allowedJoinOperators",
        .allowed_result_receivers = "allowedResultReceivers",
        .join_columns = "joinColumns",
        .list_columns = "listColumns",
    };
};
