const OnWorkflowFailure = @import("on_workflow_failure.zig").OnWorkflowFailure;
const WorkflowParameter = @import("workflow_parameter.zig").WorkflowParameter;

/// Contains control settings and configurable inputs for a workflow
/// resource.
pub const WorkflowConfiguration = struct {
    /// The action to take if the workflow fails.
    on_failure: ?OnWorkflowFailure,

    /// Test workflows are defined within named runtime groups called parallel
    /// groups.
    /// The parallel group is the named group that contains this test workflow. Test
    /// workflows within a parallel group can run at the same time. Image Builder
    /// starts up to five
    /// test workflows in the group at the same time, and starts additional
    /// workflows as
    /// others complete, until all workflows in the group have completed. This field
    /// only
    /// applies for test workflows.
    parallel_group: ?[]const u8,

    /// Contains parameter values for each of the parameters that the workflow
    /// document defined for the workflow resource.
    parameters: ?[]const WorkflowParameter,

    /// The Amazon Resource Name (ARN) of the workflow resource.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .on_failure = "onFailure",
        .parallel_group = "parallelGroup",
        .parameters = "parameters",
        .workflow_arn = "workflowArn",
    };
};
