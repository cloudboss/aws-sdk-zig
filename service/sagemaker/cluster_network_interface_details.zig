const ClusterInterfaceType = @import("cluster_interface_type.zig").ClusterInterfaceType;

/// The network interface configuration details for a Amazon SageMaker HyperPod
/// cluster instance group.
pub const ClusterNetworkInterfaceDetails = struct {
    /// The type of network interface for the instance group. Valid values are `efa`
    /// and `efa-only`.
    interface_type: ?ClusterInterfaceType = null,

    pub const json_field_names = .{
        .interface_type = "InterfaceType",
    };
};
