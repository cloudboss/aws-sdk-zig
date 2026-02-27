const ClusterCapacityRequirements = @import("cluster_capacity_requirements.zig").ClusterCapacityRequirements;
const ClusterInstanceStorageConfig = @import("cluster_instance_storage_config.zig").ClusterInstanceStorageConfig;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const ClusterKubernetesConfig = @import("cluster_kubernetes_config.zig").ClusterKubernetesConfig;
const ClusterLifeCycleConfig = @import("cluster_life_cycle_config.zig").ClusterLifeCycleConfig;
const DeepHealthCheckType = @import("deep_health_check_type.zig").DeepHealthCheckType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const ScheduledUpdateConfig = @import("scheduled_update_config.zig").ScheduledUpdateConfig;

/// The specifications of an instance group that you need to define.
pub const ClusterInstanceGroupSpecification = struct {
    /// Specifies the capacity requirements for the instance group.
    capacity_requirements: ?ClusterCapacityRequirements,

    /// Specifies an IAM execution role to be assumed by the instance group.
    execution_role: []const u8,

    /// When configuring your HyperPod cluster, you can specify an image ID using
    /// one of the following options:
    ///
    /// * `HyperPodPublicAmiId`: Use a HyperPod public AMI
    /// * `CustomAmiId`: Use your custom AMI
    /// * `default`: Use the default latest system image
    ///
    /// If you choose to use a custom AMI (`CustomAmiId`), ensure it meets the
    /// following requirements:
    ///
    /// * Encryption: The custom AMI must be unencrypted.
    /// * Ownership: The custom AMI must be owned by the same Amazon Web Services
    ///   account that is creating the HyperPod cluster.
    /// * Volume support: Only the primary AMI snapshot volume is supported;
    ///   additional AMI volumes are not supported.
    ///
    /// When updating the instance group's AMI through the `UpdateClusterSoftware`
    /// operation, if an instance group uses a custom AMI, you must provide an
    /// `ImageId` or use the default as input. Note that if you don't specify an
    /// instance group in your `UpdateClusterSoftware` request, then all of the
    /// instance groups are patched with the specified image.
    image_id: ?[]const u8,

    /// Specifies the number of instances to add to the instance group of a
    /// SageMaker HyperPod cluster.
    instance_count: i32,

    /// Specifies the name of the instance group.
    instance_group_name: []const u8,

    /// Specifies the additional storage configurations for the instances in the
    /// SageMaker HyperPod cluster instance group.
    instance_storage_configs: ?[]const ClusterInstanceStorageConfig,

    /// Specifies the instance type of the instance group.
    instance_type: ClusterInstanceType,

    /// Specifies the Kubernetes configuration for the instance group. You describe
    /// what you want the labels and taints to look like, and the cluster works to
    /// reconcile the actual state with the declared state for nodes in this
    /// instance group.
    kubernetes_config: ?ClusterKubernetesConfig,

    /// Specifies the LifeCycle configuration for the instance group.
    life_cycle_config: ClusterLifeCycleConfig,

    /// Defines the minimum number of instances required for an instance group to
    /// become `InService`. If this threshold isn't met within 3 hours, the instance
    /// group rolls back to its previous state - zero instances for new instance
    /// groups, or previous settings for existing instance groups.
    /// `MinInstanceCount` only affects the initial transition to `InService` and
    /// does not guarantee maintaining this minimum afterward.
    min_instance_count: ?i32,

    /// A flag indicating whether deep health checks should be performed when the
    /// cluster instance group is created or updated.
    on_start_deep_health_checks: ?[]const DeepHealthCheckType,

    /// To configure multi-AZ deployments, customize the Amazon VPC configuration at
    /// the instance group level. You can specify different subnets and security
    /// groups across different AZs in the instance group specification to override
    /// a SageMaker HyperPod cluster's default Amazon VPC configuration. For more
    /// information about deploying a cluster in multiple AZs, see [Setting up
    /// SageMaker HyperPod clusters across multiple
    /// AZs](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-prerequisites.html#sagemaker-hyperpod-prerequisites-multiple-availability-zones).
    ///
    /// When your Amazon VPC and subnets support IPv6, network communications differ
    /// based on the cluster orchestration platform:
    ///
    /// * Slurm-orchestrated clusters automatically configure nodes with dual IPv6
    ///   and IPv4 addresses, allowing immediate IPv6 network communications.
    /// * In Amazon EKS-orchestrated clusters, nodes receive dual-stack addressing,
    ///   but pods can only use IPv6 when the Amazon EKS cluster is explicitly
    ///   IPv6-enabled. For information about deploying an IPv6 Amazon EKS cluster,
    ///   see [Amazon EKS IPv6 Cluster
    ///   Deployment](https://docs.aws.amazon.com/eks/latest/userguide/deploy-ipv6-cluster.html#_deploy_an_ipv6_cluster_with_eksctl).
    ///
    /// Additional resources for IPv6 configuration:
    ///
    /// * For information about adding IPv6 support to your VPC, see to [IPv6
    ///   Support for
    ///   VPC](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-migrate-ipv6.html).
    /// * For information about creating a new IPv6-compatible VPC, see [Amazon VPC
    ///   Creation
    ///   Guide](https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc.html).
    /// * To configure SageMaker HyperPod with a custom Amazon VPC, see [Custom
    ///   Amazon VPC Setup for SageMaker
    ///   HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-prerequisites.html#sagemaker-hyperpod-prerequisites-optional-vpc).
    override_vpc_config: ?VpcConfig,

    /// The configuration object of the schedule that SageMaker uses to update the
    /// AMI.
    scheduled_update_config: ?ScheduledUpdateConfig,

    /// Specifies the value for **Threads per core**. For instance types that
    /// support multithreading, you can specify `1` for disabling multithreading and
    /// `2` for enabling multithreading. For instance types that doesn't support
    /// multithreading, specify `1`. For more information, see the reference table
    /// of [CPU cores and threads per CPU core per instance
    /// type](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html) in the *Amazon Elastic Compute Cloud User Guide*.
    threads_per_core: ?i32,

    /// The Amazon Resource Name (ARN); of the training plan to use for this cluster
    /// instance group.
    ///
    /// For more information about how to reserve GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn: ?[]const u8,

    pub const json_field_names = .{
        .capacity_requirements = "CapacityRequirements",
        .execution_role = "ExecutionRole",
        .image_id = "ImageId",
        .instance_count = "InstanceCount",
        .instance_group_name = "InstanceGroupName",
        .instance_storage_configs = "InstanceStorageConfigs",
        .instance_type = "InstanceType",
        .kubernetes_config = "KubernetesConfig",
        .life_cycle_config = "LifeCycleConfig",
        .min_instance_count = "MinInstanceCount",
        .on_start_deep_health_checks = "OnStartDeepHealthChecks",
        .override_vpc_config = "OverrideVpcConfig",
        .scheduled_update_config = "ScheduledUpdateConfig",
        .threads_per_core = "ThreadsPerCore",
        .training_plan_arn = "TrainingPlanArn",
    };
};
