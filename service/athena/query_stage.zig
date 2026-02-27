const QueryStagePlanNode = @import("query_stage_plan_node.zig").QueryStagePlanNode;

/// Stage statistics such as input and output rows and bytes, execution time and
/// stage
/// state. This information also includes substages and the query stage plan.
pub const QueryStage = struct {
    /// Time taken to execute this stage.
    execution_time: ?i64,

    /// The number of bytes input into the stage for execution.
    input_bytes: ?i64,

    /// The number of rows input into the stage for execution.
    input_rows: ?i64,

    /// The number of bytes output from the stage after execution.
    output_bytes: ?i64,

    /// The number of rows output from the stage after execution.
    output_rows: ?i64,

    /// Stage plan information such as name, identifier, sub plans, and source
    /// stages.
    query_stage_plan: ?QueryStagePlanNode,

    /// The identifier for a stage.
    stage_id: ?i64,

    /// State of the stage after query execution.
    state: ?[]const u8,

    /// List of sub query stages that form this stage execution plan.
    sub_stages: ?[]const QueryStage,

    pub const json_field_names = .{
        .execution_time = "ExecutionTime",
        .input_bytes = "InputBytes",
        .input_rows = "InputRows",
        .output_bytes = "OutputBytes",
        .output_rows = "OutputRows",
        .query_stage_plan = "QueryStagePlan",
        .stage_id = "StageId",
        .state = "State",
        .sub_stages = "SubStages",
    };
};
