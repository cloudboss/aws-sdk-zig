const OptimizationJobDeploymentInstanceType = @import("optimization_job_deployment_instance_type.zig").OptimizationJobDeploymentInstanceType;
const OptimizationJobStatus = @import("optimization_job_status.zig").OptimizationJobStatus;

/// Summarizes an optimization job by providing some of its key properties.
pub const OptimizationJobSummary = struct {
    /// The time when you created the optimization job.
    creation_time: i64,

    /// The type of instance that hosts the optimized model that you create with the
    /// optimization job.
    deployment_instance_type: OptimizationJobDeploymentInstanceType,

    /// The time when the optimization job was last updated.
    last_modified_time: ?i64 = null,

    /// The maximum number of instances to use for the optimization job.
    max_instance_count: ?i32 = null,

    /// The time when the optimization job finished processing.
    optimization_end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the optimization job.
    optimization_job_arn: []const u8,

    /// The name that you assigned to the optimization job.
    optimization_job_name: []const u8,

    /// The current status of the optimization job.
    optimization_job_status: OptimizationJobStatus,

    /// The time when the optimization job started.
    optimization_start_time: ?i64 = null,

    /// The optimization techniques that are applied by the optimization job.
    optimization_types: []const []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_instance_type = "DeploymentInstanceType",
        .last_modified_time = "LastModifiedTime",
        .max_instance_count = "MaxInstanceCount",
        .optimization_end_time = "OptimizationEndTime",
        .optimization_job_arn = "OptimizationJobArn",
        .optimization_job_name = "OptimizationJobName",
        .optimization_job_status = "OptimizationJobStatus",
        .optimization_start_time = "OptimizationStartTime",
        .optimization_types = "OptimizationTypes",
    };
};
