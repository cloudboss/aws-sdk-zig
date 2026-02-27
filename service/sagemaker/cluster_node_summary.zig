const ClusterInstanceStatusDetails = @import("cluster_instance_status_details.zig").ClusterInstanceStatusDetails;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;
const UltraServerInfo = @import("ultra_server_info.zig").UltraServerInfo;

/// Lists a summary of the properties of an instance (also called a *node*
/// interchangeably) of a SageMaker HyperPod cluster.
pub const ClusterNodeSummary = struct {
    /// The name of the instance group in which the instance is.
    instance_group_name: []const u8,

    /// The ID of the instance.
    instance_id: []const u8,

    /// The status of the instance.
    instance_status: ClusterInstanceStatusDetails,

    /// The type of the instance.
    instance_type: ClusterInstanceType,

    /// The time when SageMaker last updated the software of the instances in the
    /// cluster.
    last_software_update_time: ?i64,

    /// The time when the instance is launched.
    launch_time: i64,

    /// A unique identifier for the node that persists throughout its lifecycle,
    /// from provisioning request to termination. This identifier can be used to
    /// track the node even before it has an assigned `InstanceId`. This field is
    /// only included when `IncludeNodeLogicalIds` is set to `True` in the
    /// `ListClusterNodes` request.
    node_logical_id: ?[]const u8,

    /// The private DNS hostname of the SageMaker HyperPod cluster node.
    private_dns_hostname: ?[]const u8,

    /// Contains information about the UltraServer.
    ultra_server_info: ?UltraServerInfo,

    pub const json_field_names = .{
        .instance_group_name = "InstanceGroupName",
        .instance_id = "InstanceId",
        .instance_status = "InstanceStatus",
        .instance_type = "InstanceType",
        .last_software_update_time = "LastSoftwareUpdateTime",
        .launch_time = "LaunchTime",
        .node_logical_id = "NodeLogicalId",
        .private_dns_hostname = "PrivateDnsHostname",
        .ultra_server_info = "UltraServerInfo",
    };
};
