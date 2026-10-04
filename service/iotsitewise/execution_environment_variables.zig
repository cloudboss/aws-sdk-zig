const aws = @import("aws");

/// Environment variables provided as input for a pipeline execution.
pub const ExecutionEnvironmentVariables = struct {
    /// Per-compute-node environment variable overrides. Each entry maps a compute
    /// node name to its environment variable overrides.
    compute_nodes: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// Global environment variables that apply to all compute nodes in the pipeline
    /// execution.
    global: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compute_nodes = "computeNodes",
        .global = "global",
    };
};
