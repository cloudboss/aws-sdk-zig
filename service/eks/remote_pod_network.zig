/// A network CIDR that can contain pods that run Kubernetes webhooks on hybrid
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
pub const RemotePodNetwork = struct {
    /// A network CIDR that can contain pods that run Kubernetes webhooks on hybrid
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
    cidrs: ?[]const []const u8,

    pub const json_field_names = .{
        .cidrs = "cidrs",
    };
};
