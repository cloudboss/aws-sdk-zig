const WorkloadSpec = @import("workload_spec.zig").WorkloadSpec;

/// The benchmark tool configuration for an AI workload.
pub const AIWorkloadConfigs = struct {
    /// The workload specification that defines benchmark parameters.
    workload_spec: WorkloadSpec,

    pub const json_field_names = .{
        .workload_spec = "WorkloadSpec",
    };
};
