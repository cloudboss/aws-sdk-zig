const aws = @import("aws");

const Mount = @import("mount.zig").Mount;
const ComputeNodeExecutionStatus = @import("compute_node_execution_status.zig").ComputeNodeExecutionStatus;

/// Contains detailed execution information for a compute node within a pipeline
/// execution.
pub const ComputeNodeExecutionDetails = struct {
    /// The name of the compute node.
    compute_node_name: []const u8,

    /// A list of compute node names that this node depends on.
    depends_on: []const []const u8,

    /// The time the compute node execution completed, in Unix epoch time.
    end_time: ?i64 = null,

    /// The fully resolved environment variables used for this compute node
    /// execution.
    execution_environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The fully resolved mounts used for this compute node execution, after
    /// merging
    /// task-defined mounts with any execution-level mount overrides. Each mount
    /// attaches an
    /// external data source to the container filesystem at a relative path under
    /// the
    /// service-owned mount root.
    execution_mounts: ?[]const Mount = null,

    /// The time the compute node execution started, in Unix epoch time.
    start_time: ?i64 = null,

    /// The current execution status of the compute node.
    status: ComputeNodeExecutionStatus,

    /// The ARN of the task.
    task_arn: []const u8,

    /// The name of the task executed for this compute node.
    task_name: []const u8,

    /// The task version that executed for this compute node.
    task_version: []const u8,

    pub const json_field_names = .{
        .compute_node_name = "computeNodeName",
        .depends_on = "dependsOn",
        .end_time = "endTime",
        .execution_environment_variables = "executionEnvironmentVariables",
        .execution_mounts = "executionMounts",
        .start_time = "startTime",
        .status = "status",
        .task_arn = "taskArn",
        .task_name = "taskName",
        .task_version = "taskVersion",
    };
};
