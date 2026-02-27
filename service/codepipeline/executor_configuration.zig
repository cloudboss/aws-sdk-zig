const JobWorkerExecutorConfiguration = @import("job_worker_executor_configuration.zig").JobWorkerExecutorConfiguration;
const LambdaExecutorConfiguration = @import("lambda_executor_configuration.zig").LambdaExecutorConfiguration;

/// The action engine, or executor, related to the supported integration model
/// used to
/// create and update the action type. The available executor types are `Lambda`
/// and `JobWorker`.
pub const ExecutorConfiguration = struct {
    /// Details about the `JobWorker` executor of the action type.
    job_worker_executor_configuration: ?JobWorkerExecutorConfiguration,

    /// Details about the `Lambda` executor of the action type.
    lambda_executor_configuration: ?LambdaExecutorConfiguration,

    pub const json_field_names = .{
        .job_worker_executor_configuration = "jobWorkerExecutorConfiguration",
        .lambda_executor_configuration = "lambdaExecutorConfiguration",
    };
};
