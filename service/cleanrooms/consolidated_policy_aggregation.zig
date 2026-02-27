const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;
const AggregateColumn = @import("aggregate_column.zig").AggregateColumn;
const JoinOperator = @import("join_operator.zig").JoinOperator;
const JoinRequiredOption = @import("join_required_option.zig").JoinRequiredOption;
const AggregationConstraint = @import("aggregation_constraint.zig").AggregationConstraint;
const ScalarFunctions = @import("scalar_functions.zig").ScalarFunctions;

/// Controls on the analysis specifications that can be run on a configured
/// table.
pub const ConsolidatedPolicyAggregation = struct {
    /// Additional analyses for the consolidated policy aggregation.
    additional_analyses: ?AdditionalAnalyses,

    /// Aggregate columns in consolidated policy aggregation.
    aggregate_columns: []const AggregateColumn,

    /// The additional analyses allowed by the consolidated policy aggregation.
    allowed_additional_analyses: ?[]const []const u8,

    /// The allowed join operators.
    allowed_join_operators: ?[]const JoinOperator,

    /// The allowed result receivers.
    allowed_result_receivers: ?[]const []const u8,

    /// The dimension columns of the consolidated policy aggregation.
    dimension_columns: []const []const u8,

    /// The columns to join on.
    join_columns: []const []const u8,

    /// Join required
    join_required: ?JoinRequiredOption,

    /// The output constraints of the consolidated policy aggregation.
    output_constraints: []const AggregationConstraint,

    /// The scalar functions.
    scalar_functions: []const ScalarFunctions,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .aggregate_columns = "aggregateColumns",
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_join_operators = "allowedJoinOperators",
        .allowed_result_receivers = "allowedResultReceivers",
        .dimension_columns = "dimensionColumns",
        .join_columns = "joinColumns",
        .join_required = "joinRequired",
        .output_constraints = "outputConstraints",
        .scalar_functions = "scalarFunctions",
    };
};
