const ClusterInterfaceType = @import("cluster_interface_type.zig").ClusterInterfaceType;

/// The network interface configuration for a Amazon SageMaker HyperPod cluster
/// instance group.
pub const ClusterNetworkInterface = struct {
    /// The type of network interface for the instance group. Valid values:
    ///
    /// * `efa` – An EFA with ENA interface, which provides both the EFA device for
    ///   low-latency, high-throughput communication and the ENA device for IP
    ///   networking.
    /// * `efa-only` – An EFA-only interface, which provides only the EFA device
    ///   capabilities without the ENA device for traditional IP networking.
    ///
    /// For more information, see [Elastic Fabric
    /// Adapter](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/efa.html).
    interface_type: ?ClusterInterfaceType = null,

    pub const json_field_names = .{
        .interface_type = "InterfaceType",
    };
};
