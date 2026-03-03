const RemoteNodeNetwork = @import("remote_node_network.zig").RemoteNodeNetwork;
const RemotePodNetwork = @import("remote_pod_network.zig").RemotePodNetwork;

/// The configuration in the cluster for EKS Hybrid Nodes. You can add, change,
/// or remove this
/// configuration after the cluster is created.
pub const RemoteNetworkConfigResponse = struct {
    /// The list of network CIDRs that can contain hybrid nodes.
    remote_node_networks: ?[]const RemoteNodeNetwork = null,

    /// The list of network CIDRs that can contain pods that run Kubernetes webhooks
    /// on hybrid
    /// nodes.
    remote_pod_networks: ?[]const RemotePodNetwork = null,

    pub const json_field_names = .{
        .remote_node_networks = "remoteNodeNetworks",
        .remote_pod_networks = "remotePodNetworks",
    };
};
