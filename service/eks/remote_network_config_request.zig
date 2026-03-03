const RemoteNodeNetwork = @import("remote_node_network.zig").RemoteNodeNetwork;
const RemotePodNetwork = @import("remote_pod_network.zig").RemotePodNetwork;

/// The configuration in the cluster for EKS Hybrid Nodes. You can add, change,
/// or remove this
/// configuration after the cluster is created.
pub const RemoteNetworkConfigRequest = struct {
    /// The list of network CIDRs that can contain hybrid nodes.
    ///
    /// These CIDR blocks define the expected IP address range of the hybrid nodes
    /// that join
    /// the cluster. These blocks are typically determined by your network
    /// administrator.
    ///
    /// Enter one or more IPv4 CIDR blocks in decimal dotted-quad notation (for
    /// example,
    /// ` 10.2.0.0/16`).
    ///
    /// It must satisfy the following requirements:
    ///
    /// * Each block must be within an `IPv4` RFC-1918 network range. Minimum
    /// allowed size is /32, maximum allowed size is /8. Publicly-routable addresses
    /// aren't supported.
    ///
    /// * Each block cannot overlap with the range of the VPC CIDR blocks for your
    ///   EKS
    /// resources, or the block of the Kubernetes service IP range.
    ///
    /// * Each block must have a route to the VPC that uses the VPC CIDR blocks, not
    /// public IPs or Elastic IPs. There are many options including Transit Gateway,
    /// Site-to-Site VPN, or Direct Connect.
    ///
    /// * Each host must allow outbound connection to the EKS cluster control plane
    ///   on
    /// TCP ports `443` and `10250`.
    ///
    /// * Each host must allow inbound connection from the EKS cluster control plane
    ///   on
    /// TCP port 10250 for logs, exec and port-forward operations.
    ///
    /// * Each host must allow TCP and UDP network connectivity to and from other
    ///   hosts
    /// that are running `CoreDNS` on UDP port `53` for service and pod DNS
    /// names.
    remote_node_networks: ?[]const RemoteNodeNetwork = null,

    /// The list of network CIDRs that can contain pods that run Kubernetes webhooks
    /// on hybrid
    /// nodes.
    ///
    /// These CIDR blocks are determined by configuring your Container Network
    /// Interface (CNI)
    /// plugin. We recommend the Calico CNI or Cilium CNI. Note that the Amazon VPC
    /// CNI plugin for Kubernetes isn't
    /// available for on-premises and edge locations.
    ///
    /// Enter one or more IPv4 CIDR blocks in decimal dotted-quad notation (for
    /// example,
    /// ` 10.2.0.0/16`).
    ///
    /// It must satisfy the following requirements:
    ///
    /// * Each block must be within an `IPv4` RFC-1918 network range. Minimum
    /// allowed size is /32, maximum allowed size is /8. Publicly-routable addresses
    /// aren't supported.
    ///
    /// * Each block cannot overlap with the range of the VPC CIDR blocks for your
    ///   EKS
    /// resources, or the block of the Kubernetes service IP range.
    remote_pod_networks: ?[]const RemotePodNetwork = null,

    pub const json_field_names = .{
        .remote_node_networks = "remoteNodeNetworks",
        .remote_pod_networks = "remotePodNetworks",
    };
};
