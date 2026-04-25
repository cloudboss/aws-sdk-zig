const aws = @import("aws");

const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const ClusterCapacityRequirements = @import("cluster_capacity_requirements.zig").ClusterCapacityRequirements;
const ClusterInstanceRequirementDetails = @import("cluster_instance_requirement_details.zig").ClusterInstanceRequirementDetails;
const ClusterInstanceStorageConfig = @import("cluster_instance_storage_config.zig").ClusterInstanceStorageConfig;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const ClusterInstanceTypeDetail = @import("cluster_instance_type_detail.zig").ClusterInstanceTypeDetail;
const ClusterKubernetesConfigDetails = @import("cluster_kubernetes_config_details.zig").ClusterKubernetesConfigDetails;
const ClusterLifeCycleConfig = @import("cluster_life_cycle_config.zig").ClusterLifeCycleConfig;
const ClusterNetworkInterfaceDetails = @import("cluster_network_interface_details.zig").ClusterNetworkInterfaceDetails;
const DeepHealthCheckType = @import("deep_health_check_type.zig").DeepHealthCheckType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const ScheduledUpdateConfig = @import("scheduled_update_config.zig").ScheduledUpdateConfig;
const ClusterSlurmConfigDetails = @import("cluster_slurm_config_details.zig").ClusterSlurmConfigDetails;
const SoftwareUpdateStatus = @import("software_update_status.zig").SoftwareUpdateStatus;
const InstanceGroupStatus = @import("instance_group_status.zig").InstanceGroupStatus;

/// Details of an instance group in a SageMaker HyperPod cluster.
pub const ClusterInstanceGroupDetails = struct {
    /// A map indicating active operations currently in progress for the instance
    /// group of a SageMaker HyperPod cluster. When there is a scaling operation in
    /// progress, this map contains a key `Scaling` with value 1.
    active_operations: ?[]const aws.map.MapEntry(i32) = null,

    active_software_update_config: ?DeploymentConfiguration = null,

    /// The instance capacity requirements for the instance group.
    capacity_requirements: ?ClusterCapacityRequirements = null,

    /// The number of instances that are currently in the instance group of a
    /// SageMaker HyperPod cluster.
    current_count: ?i32 = null,

    /// The ID of the Amazon Machine Image (AMI) currently in use by the instance
    /// group.
    current_image_id: ?[]const u8 = null,

    /// The ID of the Amazon Machine Image (AMI) desired for the instance group.
    desired_image_id: ?[]const u8 = null,

    /// The execution role for the instance group to assume.
    execution_role: ?[]const u8 = null,

    /// The name of the instance group of a SageMaker HyperPod cluster.
    instance_group_name: ?[]const u8 = null,

    /// The instance requirements for the instance group, including the current and
    /// desired instance types. This field is present for flexible instance groups
    /// that support multiple instance types.
    instance_requirements: ?ClusterInstanceRequirementDetails = null,

    /// The additional storage configurations for the instances in the SageMaker
    /// HyperPod cluster instance group.
    instance_storage_configs: ?[]const ClusterInstanceStorageConfig = null,

    /// The instance type of the instance group of a SageMaker HyperPod cluster.
    instance_type: ?ClusterInstanceType = null,

    /// Details about the instance types in the instance group, including the count
    /// and configuration of each instance type. This field is present for flexible
    /// instance groups that support multiple instance types.
    instance_type_details: ?[]const ClusterInstanceTypeDetail = null,

    /// The Kubernetes configuration for the instance group that contains labels and
    /// taints to be applied for the nodes in this instance group.
    kubernetes_config: ?ClusterKubernetesConfigDetails = null,

    /// Details of LifeCycle configuration for the instance group.
    life_cycle_config: ?ClusterLifeCycleConfig = null,

    /// The minimum number of instances that must be available in the instance group
    /// of a SageMaker HyperPod cluster before it transitions to `InService` status.
    min_count: ?i32 = null,

    /// The network interface configuration for the instance group.
    network_interface: ?ClusterNetworkInterfaceDetails = null,

    /// A flag indicating whether deep health checks should be performed when the
    /// cluster instance group is created or updated.
    on_start_deep_health_checks: ?[]const DeepHealthCheckType = null,

    /// The customized Amazon VPC configuration at the instance group level that
    /// overrides the default Amazon VPC configuration of the SageMaker HyperPod
    /// cluster.
    override_vpc_config: ?VpcConfig = null,

    /// The configuration object of the schedule that SageMaker follows when
    /// updating the AMI.
    scheduled_update_config: ?ScheduledUpdateConfig = null,

    /// The Slurm configuration for the instance group.
    slurm_config: ?ClusterSlurmConfigDetails = null,

    /// Status of the last software udpate request.
    ///
    /// Status transitions follow these possible sequences:
    ///
    /// * Pending -> InProgress -> Succeeded
    /// * Pending -> InProgress -> RollbackInProgress -> RollbackComplete
    /// * Pending -> InProgress -> RollbackInProgress -> Failed
    software_update_status: ?SoftwareUpdateStatus = null,

    /// The current status of the cluster instance group.
    ///
    /// * `InService`: The instance group is active and healthy.
    /// * `Creating`: The instance group is being provisioned.
    /// * `Updating`: The instance group is being updated.
    /// * `Failed`: The instance group has failed to provision or is no longer
    ///   healthy.
    /// * `Degraded`: The instance group is degraded, meaning that some instances
    ///   have failed to provision or are no longer healthy.
    /// * `Deleting`: The instance group is being deleted.
    status: ?InstanceGroupStatus = null,

    /// The number of instances you specified to add to the instance group of a
    /// SageMaker HyperPod cluster.
    target_count: ?i32 = null,

    /// Represents the number of running nodes using the desired Image ID.
    ///
    /// * **During software update operations:** This count shows the number of
    ///   nodes running on the desired Image ID. If a rollback occurs, the current
    ///   image ID and desired image ID (both included in the describe cluster
    ///   response) swap values. The TargetStateCount then shows the number of nodes
    ///   running on the newly designated desired image ID (which was previously the
    ///   current image ID).
    /// * **During simultaneous scaling and software update operations:** This count
    ///   shows the number of instances running on the desired image ID, including
    ///   any new instances created as part of the scaling request. New nodes are
    ///   always created using the desired image ID, so TargetStateCount reflects
    ///   the total count of nodes running on the desired image ID, even during
    ///   rollback scenarios.
    target_state_count: ?i32 = null,

    /// The number you specified to `TreadsPerCore` in `CreateCluster` for enabling
    /// or disabling multithreading. For instance types that support multithreading,
    /// you can specify 1 for disabling multithreading and 2 for enabling
    /// multithreading. For more information, see the reference table of [CPU cores
    /// and threads per CPU core per instance
    /// type](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html) in the *Amazon Elastic Compute Cloud User Guide*.
    threads_per_core: ?i32 = null,

    /// The Amazon Resource Name (ARN); of the training plan associated with this
    /// cluster instance group.
    ///
    /// For more information about how to reserve GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn: ?[]const u8 = null,

    /// The current status of the training plan associated with this cluster
    /// instance group.
    training_plan_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_operations = "ActiveOperations",
        .active_software_update_config = "ActiveSoftwareUpdateConfig",
        .capacity_requirements = "CapacityRequirements",
        .current_count = "CurrentCount",
        .current_image_id = "CurrentImageId",
        .desired_image_id = "DesiredImageId",
        .execution_role = "ExecutionRole",
        .instance_group_name = "InstanceGroupName",
        .instance_requirements = "InstanceRequirements",
        .instance_storage_configs = "InstanceStorageConfigs",
        .instance_type = "InstanceType",
        .instance_type_details = "InstanceTypeDetails",
        .kubernetes_config = "KubernetesConfig",
        .life_cycle_config = "LifeCycleConfig",
        .min_count = "MinCount",
        .network_interface = "NetworkInterface",
        .on_start_deep_health_checks = "OnStartDeepHealthChecks",
        .override_vpc_config = "OverrideVpcConfig",
        .scheduled_update_config = "ScheduledUpdateConfig",
        .slurm_config = "SlurmConfig",
        .software_update_status = "SoftwareUpdateStatus",
        .status = "Status",
        .target_count = "TargetCount",
        .target_state_count = "TargetStateCount",
        .threads_per_core = "ThreadsPerCore",
        .training_plan_arn = "TrainingPlanArn",
        .training_plan_status = "TrainingPlanStatus",
    };
};
