const aws = @import("aws");

const WorkflowGraph = @import("workflow_graph.zig").WorkflowGraph;
const StartingEventBatchCondition = @import("starting_event_batch_condition.zig").StartingEventBatchCondition;
const WorkflowRunStatistics = @import("workflow_run_statistics.zig").WorkflowRunStatistics;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

/// A workflow run is an execution of a workflow providing all the runtime
/// information.
pub const WorkflowRun = struct {
    /// The date and time when the workflow run completed.
    completed_on: ?i64,

    /// This error message describes any error that may have occurred in starting
    /// the workflow run. Currently the only error message is "Concurrent runs
    /// exceeded for workflow: `foo`."
    error_message: ?[]const u8,

    /// The graph representing all the Glue components that belong to the workflow
    /// as nodes and directed
    /// connections between them as edges.
    graph: ?WorkflowGraph,

    /// Name of the workflow that was run.
    name: ?[]const u8,

    /// The ID of the previous workflow run.
    previous_run_id: ?[]const u8,

    /// The date and time when the workflow run was started.
    started_on: ?i64,

    /// The batch condition that started the workflow run.
    starting_event_batch_condition: ?StartingEventBatchCondition,

    /// The statistics of the run.
    statistics: ?WorkflowRunStatistics,

    /// The status of the workflow run.
    status: ?WorkflowRunStatus,

    /// The ID of this workflow run.
    workflow_run_id: ?[]const u8,

    /// The workflow run properties which were set during the run.
    workflow_run_properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .completed_on = "CompletedOn",
        .error_message = "ErrorMessage",
        .graph = "Graph",
        .name = "Name",
        .previous_run_id = "PreviousRunId",
        .started_on = "StartedOn",
        .starting_event_batch_condition = "StartingEventBatchCondition",
        .statistics = "Statistics",
        .status = "Status",
        .workflow_run_id = "WorkflowRunId",
        .workflow_run_properties = "WorkflowRunProperties",
    };
};
