const EnvironmentConfigDetails = @import("environment_config_details.zig").EnvironmentConfigDetails;
const ClusterInstanceStorageConfig = @import("cluster_instance_storage_config.zig").ClusterInstanceStorageConfig;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const DeepHealthCheckType = @import("deep_health_check_type.zig").DeepHealthCheckType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const ScheduledUpdateConfig = @import("scheduled_update_config.zig").ScheduledUpdateConfig;
const InstanceGroupStatus = @import("instance_group_status.zig").InstanceGroupStatus;

/// The instance group details of the restricted instance group (RIG).
pub const ClusterRestrictedInstanceGroupDetails = struct {
    /// The number of instances that are currently in the restricted instance group
    /// of a SageMaker HyperPod cluster.
    current_count: ?i32,

    /// The configuration for the restricted instance groups (RIG) environment.
    environment_config: ?EnvironmentConfigDetails,

    /// The execution role for the restricted instance group to assume.
    execution_role: ?[]const u8,

    /// The name of the restricted instance group of a SageMaker HyperPod cluster.
    instance_group_name: ?[]const u8,

    /// The additional storage configurations for the instances in the SageMaker
    /// HyperPod cluster restricted instance group.
    instance_storage_configs: ?[]const ClusterInstanceStorageConfig,

    /// The instance type of the restricted instance group of a SageMaker HyperPod
    /// cluster.
    instance_type: ?ClusterInstanceType,

    /// A flag indicating whether deep health checks should be performed when the
    /// cluster's restricted instance group is created or updated.
    on_start_deep_health_checks: ?[]const DeepHealthCheckType,

    override_vpc_config: ?VpcConfig,

    scheduled_update_config: ?ScheduledUpdateConfig,

    /// The current status of the cluster's restricted instance group.
    ///
    /// * `InService`: The restricted instance group is active and healthy.
    /// * `Creating`: The restricted instance group is being provisioned.
    /// * `Updating`: The restricted instance group is being updated.
    /// * `Failed`: The restricted instance group has failed to provision or is no
    ///   longer healthy.
    /// * `Degraded`: The restricted instance group is degraded, meaning that some
    ///   instances have failed to provision or are no longer healthy.
    /// * `Deleting`: The restricted instance group is being deleted.
    status: ?InstanceGroupStatus,

    /// The number of instances you specified to add to the restricted instance
    /// group of a SageMaker HyperPod cluster.
    target_count: ?i32,

    /// The number you specified to `TreadsPerCore` in `CreateCluster` for enabling
    /// or disabling multithreading. For instance types that support multithreading,
    /// you can specify 1 for disabling multithreading and 2 for enabling
    /// multithreading. For more information, see the reference table of [CPU cores
    /// and threads per CPU core per instance
    /// type](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html) in the *Amazon Elastic Compute Cloud User Guide*.
    threads_per_core: ?i32,

    /// The Amazon Resource Name (ARN) of the training plan to filter clusters by.
    /// For more information about reserving GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn: ?[]const u8,

    /// The current status of the training plan associated with this cluster
    /// restricted instance group.
    training_plan_status: ?[]const u8,

    pub const json_field_names = .{
        .current_count = "CurrentCount",
        .environment_config = "EnvironmentConfig",
        .execution_role = "ExecutionRole",
        .instance_group_name = "InstanceGroupName",
        .instance_storage_configs = "InstanceStorageConfigs",
        .instance_type = "InstanceType",
        .on_start_deep_health_checks = "OnStartDeepHealthChecks",
        .override_vpc_config = "OverrideVpcConfig",
        .scheduled_update_config = "ScheduledUpdateConfig",
        .status = "Status",
        .target_count = "TargetCount",
        .threads_per_core = "ThreadsPerCore",
        .training_plan_arn = "TrainingPlanArn",
        .training_plan_status = "TrainingPlanStatus",
    };
};
