const aws = @import("aws");

/// A single compute node in a pipeline DAG. Each compute node references a task
/// and can declare dependencies on other nodes.
pub const ComputeNode = struct {
    /// The unique name for this compute node within the pipeline.
    compute_node_name: []const u8,

    /// A list of compute node names that must complete successfully before this
    /// node can start.
    depends_on: ?[]const []const u8 = null,

    /// Environment variables specific to this compute node. These override
    /// pipeline-level environment variables with the same key.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The name of the task to execute for this compute node.
    task_name: []const u8,

    pub const json_field_names = .{
        .compute_node_name = "computeNodeName",
        .depends_on = "dependsOn",
        .environment_variables = "environmentVariables",
        .task_name = "taskName",
    };
};
