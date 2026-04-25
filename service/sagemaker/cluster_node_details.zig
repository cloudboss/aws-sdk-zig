const ClusterCapacityType = @import("cluster_capacity_type.zig").ClusterCapacityType;
const ClusterInstanceStatusDetails = @import("cluster_instance_status_details.zig").ClusterInstanceStatusDetails;
const ClusterInstanceStorageConfig = @import("cluster_instance_storage_config.zig").ClusterInstanceStorageConfig;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const ClusterKubernetesConfigNodeDetails = @import("cluster_kubernetes_config_node_details.zig").ClusterKubernetesConfigNodeDetails;
const ClusterLifeCycleConfig = @import("cluster_life_cycle_config.zig").ClusterLifeCycleConfig;
const ClusterNetworkInterfaceDetails = @import("cluster_network_interface_details.zig").ClusterNetworkInterfaceDetails;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const ClusterInstancePlacement = @import("cluster_instance_placement.zig").ClusterInstancePlacement;
const UltraServerInfo = @import("ultra_server_info.zig").UltraServerInfo;

/// Details of an instance (also called a *node* interchangeably) in a SageMaker
/// HyperPod cluster.
pub const ClusterNodeDetails = struct {
    /// The capacity type of the node. Valid values are `OnDemand` and `Spot`. When
    /// set to `OnDemand`, the node is launched as an On-Demand instance. When set
    /// to `Spot`, the node is launched as a Spot instance.
    capacity_type: ?ClusterCapacityType = null,

    /// The ID of the Amazon Machine Image (AMI) currently in use by the node.
    current_image_id: ?[]const u8 = null,

    /// The ID of the Amazon Machine Image (AMI) desired for the node.
    desired_image_id: ?[]const u8 = null,

    /// The instance group name in which the instance is.
    instance_group_name: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The status of the instance.
    instance_status: ?ClusterInstanceStatusDetails = null,

    /// The configurations of additional storage specified to the instance group
    /// where the instance (node) is launched.
    instance_storage_configs: ?[]const ClusterInstanceStorageConfig = null,

    /// The type of the instance.
    instance_type: ?ClusterInstanceType = null,

    /// The Kubernetes configuration applied to this node, showing both the current
    /// and desired state of labels and taints. The cluster works to reconcile the
    /// actual state with the declared state.
    kubernetes_config: ?ClusterKubernetesConfigNodeDetails = null,

    /// The time when the cluster was last updated.
    last_software_update_time: ?i64 = null,

    /// The time when the instance is launched.
    launch_time: ?i64 = null,

    /// The LifeCycle configuration applied to the instance.
    life_cycle_config: ?ClusterLifeCycleConfig = null,

    /// The network interface configuration for the cluster node.
    network_interface: ?ClusterNetworkInterfaceDetails = null,

    /// A unique identifier for the node that persists throughout its lifecycle,
    /// from provisioning request to termination. This identifier can be used to
    /// track the node even before it has an assigned `InstanceId`.
    node_logical_id: ?[]const u8 = null,

    /// The customized Amazon VPC configuration at the instance group level that
    /// overrides the default Amazon VPC configuration of the SageMaker HyperPod
    /// cluster.
    override_vpc_config: ?VpcConfig = null,

    /// The placement details of the SageMaker HyperPod cluster node.
    placement: ?ClusterInstancePlacement = null,

    /// The private DNS hostname of the SageMaker HyperPod cluster node.
    private_dns_hostname: ?[]const u8 = null,

    /// The private primary IP address of the SageMaker HyperPod cluster node.
    private_primary_ip: ?[]const u8 = null,

    /// The private primary IPv6 address of the SageMaker HyperPod cluster node when
    /// configured with an Amazon VPC that supports IPv6 and includes subnets with
    /// IPv6 addressing enabled in either the cluster Amazon VPC configuration or
    /// the instance group Amazon VPC configuration.
    private_primary_ipv_6: ?[]const u8 = null,

    /// The number of threads per CPU core you specified under `CreateCluster`.
    threads_per_core: ?i32 = null,

    /// Contains information about the UltraServer.
    ultra_server_info: ?UltraServerInfo = null,

    pub const json_field_names = .{
        .capacity_type = "CapacityType",
        .current_image_id = "CurrentImageId",
        .desired_image_id = "DesiredImageId",
        .instance_group_name = "InstanceGroupName",
        .instance_id = "InstanceId",
        .instance_status = "InstanceStatus",
        .instance_storage_configs = "InstanceStorageConfigs",
        .instance_type = "InstanceType",
        .kubernetes_config = "KubernetesConfig",
        .last_software_update_time = "LastSoftwareUpdateTime",
        .launch_time = "LaunchTime",
        .life_cycle_config = "LifeCycleConfig",
        .network_interface = "NetworkInterface",
        .node_logical_id = "NodeLogicalId",
        .override_vpc_config = "OverrideVpcConfig",
        .placement = "Placement",
        .private_dns_hostname = "PrivateDnsHostname",
        .private_primary_ip = "PrivatePrimaryIp",
        .private_primary_ipv_6 = "PrivatePrimaryIpv6",
        .threads_per_core = "ThreadsPerCore",
        .ultra_server_info = "UltraServerInfo",
    };
};
