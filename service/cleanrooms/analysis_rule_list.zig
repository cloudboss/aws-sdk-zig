const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const JoinOperator = @import("join_operator.zig").JoinOperator;

/// A type of analysis rule that enables row-level analysis.
pub const AnalysisRuleList = struct {
    /// An indicator as to whether additional analyses (such as Clean Rooms ML) can
    /// be applied to the output of the direct query.
    additional_analyses: ?AdditionalAnalyses = null,

    /// The logical operators (if any) that are to be used in an INNER JOIN match
    /// condition. Default is `AND`.
    allowed_join_operators: ?[]const JoinOperator = null,

    /// Columns that can be used to join a configured table with the table of the
    /// member who can query and other members' configured tables.
    join_columns: []const []const u8,

    /// Columns that can be listed in the output.
    list_columns: []const []const u8,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .allowed_join_operators = "allowedJoinOperators",
        .join_columns = "joinColumns",
        .list_columns = "listColumns",
    };
};
