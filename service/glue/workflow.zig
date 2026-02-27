const aws = @import("aws");

const BlueprintDetails = @import("blueprint_details.zig").BlueprintDetails;
const WorkflowGraph = @import("workflow_graph.zig").WorkflowGraph;
const WorkflowRun = @import("workflow_run.zig").WorkflowRun;

/// A workflow is a collection of multiple dependent Glue
/// jobs and crawlers that are run to complete a complex ETL task. A
/// workflow manages the execution and monitoring of all its jobs and crawlers.
pub const Workflow = struct {
    /// This structure indicates the details of the blueprint that this particular
    /// workflow is created from.
    blueprint_details: ?BlueprintDetails,

    /// The date and time when the workflow was created.
    created_on: ?i64,

    /// A collection of properties to be used as part of each execution of the
    /// workflow.
    /// The run properties are made available to each job in the workflow. A job can
    /// modify
    /// the properties for the next jobs in the flow.
    default_run_properties: ?[]const aws.map.StringMapEntry,

    /// A description of the workflow.
    description: ?[]const u8,

    /// The graph representing all the Glue components that belong to the workflow
    /// as nodes and directed
    /// connections between them as edges.
    graph: ?WorkflowGraph,

    /// The date and time when the workflow was last modified.
    last_modified_on: ?i64,

    /// The information about the last execution of the workflow.
    last_run: ?WorkflowRun,

    /// You can use this parameter to prevent unwanted multiple updates to data, to
    /// control costs, or in some cases, to prevent exceeding the maximum number of
    /// concurrent runs of any of the component jobs. If you leave this parameter
    /// blank, there is no limit to the number of concurrent workflow runs.
    max_concurrent_runs: ?i32,

    /// The name of the workflow.
    name: ?[]const u8,

    pub const json_field_names = .{
        .blueprint_details = "BlueprintDetails",
        .created_on = "CreatedOn",
        .default_run_properties = "DefaultRunProperties",
        .description = "Description",
        .graph = "Graph",
        .last_modified_on = "LastModifiedOn",
        .last_run = "LastRun",
        .max_concurrent_runs = "MaxConcurrentRuns",
        .name = "Name",
    };
};
