const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const AggregateColumn = @import("aggregate_column.zig").AggregateColumn;
const JoinOperator = @import("join_operator.zig").JoinOperator;
const JoinRequiredOption = @import("join_required_option.zig").JoinRequiredOption;
const AggregationConstraint = @import("aggregation_constraint.zig").AggregationConstraint;
const ScalarFunctions = @import("scalar_functions.zig").ScalarFunctions;

/// A type of analysis rule that enables query structure and specified queries
/// that produce aggregate statistics.
pub const AnalysisRuleAggregation = struct {
    /// An indicator as to whether additional analyses (such as Clean Rooms ML) can
    /// be applied to the output of the direct query.
    ///
    /// The `additionalAnalyses` parameter is currently supported for the list
    /// analysis rule (`AnalysisRuleList`) and the custom analysis rule
    /// (`AnalysisRuleCustom`).
    additional_analyses: ?AdditionalAnalyses,

    /// The columns that query runners are allowed to use in aggregation queries.
    aggregate_columns: []const AggregateColumn,

    /// Which logical operators (if any) are to be used in an INNER JOIN match
    /// condition. Default is `AND`.
    allowed_join_operators: ?[]const JoinOperator,

    /// The columns that query runners are allowed to select, group by, or filter
    /// by.
    dimension_columns: []const []const u8,

    /// Columns in configured table that can be used in join statements and/or as
    /// aggregate columns. They can never be outputted directly.
    join_columns: []const []const u8,

    /// Control that requires member who runs query to do a join with their
    /// configured table and/or other configured table in query.
    join_required: ?JoinRequiredOption,

    /// Columns that must meet a specific threshold value (after an aggregation
    /// function is applied to it) for each output row to be returned.
    output_constraints: []const AggregationConstraint,

    /// Set of scalar functions that are allowed to be used on dimension columns and
    /// the output of aggregation of metrics.
    scalar_functions: []const ScalarFunctions,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .aggregate_columns = "aggregateColumns",
        .allowed_join_operators = "allowedJoinOperators",
        .dimension_columns = "dimensionColumns",
        .join_columns = "joinColumns",
        .join_required = "joinRequired",
        .output_constraints = "outputConstraints",
        .scalar_functions = "scalarFunctions",
    };
};
