/// Configuration for Lambda-managed instances used by the capacity provider.
pub const LambdaManagedInstancesCapacityProviderConfig = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// The amount of memory in GiB allocated per vCPU for execution environments.
    execution_environment_memory_gi_b_per_v_cpu: ?f64 = null,

    /// The maximum number of concurrent execution environments that can run on each
    /// compute instance.
    per_execution_environment_max_concurrency: ?i32 = null,

    pub const json_field_names = .{
        .capacity_provider_arn = "CapacityProviderArn",
        .execution_environment_memory_gi_b_per_v_cpu = "ExecutionEnvironmentMemoryGiBPerVCpu",
        .per_execution_environment_max_concurrency = "PerExecutionEnvironmentMaxConcurrency",
    };
};
