const EnvironmentConfig = @import("environment_config.zig").EnvironmentConfig;
const ClusterInstanceStorageConfig = @import("cluster_instance_storage_config.zig").ClusterInstanceStorageConfig;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const DeepHealthCheckType = @import("deep_health_check_type.zig").DeepHealthCheckType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const ScheduledUpdateConfig = @import("scheduled_update_config.zig").ScheduledUpdateConfig;

/// The specifications of a restricted instance group that you need to define.
pub const ClusterRestrictedInstanceGroupSpecification = struct {
    /// The configuration for the restricted instance groups (RIG) environment.
    environment_config: EnvironmentConfig,

    /// Specifies an IAM execution role to be assumed by the restricted instance
    /// group.
    execution_role: []const u8,

    /// Specifies the number of instances to add to the restricted instance group of
    /// a SageMaker HyperPod cluster.
    instance_count: i32,

    /// Specifies the name of the restricted instance group.
    instance_group_name: []const u8,

    /// Specifies the additional storage configurations for the instances in the
    /// SageMaker HyperPod cluster restricted instance group.
    instance_storage_configs: ?[]const ClusterInstanceStorageConfig = null,

    /// Specifies the instance type of the restricted instance group.
    instance_type: ClusterInstanceType,

    /// A flag indicating whether deep health checks should be performed when the
    /// cluster restricted instance group is created or updated.
    on_start_deep_health_checks: ?[]const DeepHealthCheckType = null,

    override_vpc_config: ?VpcConfig = null,

    scheduled_update_config: ?ScheduledUpdateConfig = null,

    /// The number you specified to `TreadsPerCore` in `CreateCluster` for enabling
    /// or disabling multithreading. For instance types that support multithreading,
    /// you can specify 1 for disabling multithreading and 2 for enabling
    /// multithreading. For more information, see the reference table of [CPU cores
    /// and threads per CPU core per instance
    /// type](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html) in the *Amazon Elastic Compute Cloud User Guide*.
    threads_per_core: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the training plan to filter clusters by.
    /// For more information about reserving GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_config = "EnvironmentConfig",
        .execution_role = "ExecutionRole",
        .instance_count = "InstanceCount",
        .instance_group_name = "InstanceGroupName",
        .instance_storage_configs = "InstanceStorageConfigs",
        .instance_type = "InstanceType",
        .on_start_deep_health_checks = "OnStartDeepHealthChecks",
        .override_vpc_config = "OverrideVpcConfig",
        .scheduled_update_config = "ScheduledUpdateConfig",
        .threads_per_core = "ThreadsPerCore",
        .training_plan_arn = "TrainingPlanArn",
    };
};
