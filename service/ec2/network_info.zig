const BandwidthWeightingType = @import("bandwidth_weighting_type.zig").BandwidthWeightingType;
const DefaultConnectionTrackingConfiguration = @import("default_connection_tracking_configuration.zig").DefaultConnectionTrackingConfiguration;
const EfaInfo = @import("efa_info.zig").EfaInfo;
const EnaSupport = @import("ena_support.zig").EnaSupport;
const FlexibleEnaQueuesSupport = @import("flexible_ena_queues_support.zig").FlexibleEnaQueuesSupport;
const NetworkCardInfo = @import("network_card_info.zig").NetworkCardInfo;

/// Describes the networking features of the instance type.
pub const NetworkInfo = struct {
    /// A list of valid settings for configurable bandwidth weighting for the
    /// instance type, if
    /// supported.
    bandwidth_weightings: ?[]const BandwidthWeightingType = null,

    /// Indicates conntrack information for the instance type
    connection_tracking_configuration: ?DefaultConnectionTrackingConfiguration = null,

    /// The index of the default network card, starting at 0.
    default_network_card_index: ?i32 = null,

    /// Describes the Elastic Fabric Adapters for the instance type.
    efa_info: ?EfaInfo = null,

    /// Indicates whether Elastic Fabric Adapter (EFA) is supported.
    efa_supported: ?bool = null,

    /// Indicates whether the instance type supports ENA Express. ENA Express uses
    /// Amazon Web Services Scalable Reliable Datagram (SRD) technology to increase
    /// the maximum bandwidth used per stream
    /// and minimize tail latency of network traffic between EC2 instances.
    ena_srd_supported: ?bool = null,

    /// Indicates whether Elastic Network Adapter (ENA) is supported.
    ena_support: ?EnaSupport = null,

    /// Indicates whether the instance type automatically encrypts in-transit
    /// traffic between
    /// instances.
    encryption_in_transit_supported: ?bool = null,

    /// Indicates whether changing the number of ENA queues is supported.
    flexible_ena_queues_support: ?FlexibleEnaQueuesSupport = null,

    /// The maximum number of IPv4 addresses per network interface.
    ipv_4_addresses_per_interface: ?i32 = null,

    /// The maximum number of IPv4 addresses per secondary interface.
    ipv_4_addresses_per_secondary_interface: ?i32 = null,

    /// The maximum number of IPv6 addresses per network interface.
    ipv_6_addresses_per_interface: ?i32 = null,

    /// Indicates whether IPv6 is supported.
    ipv_6_supported: ?bool = null,

    /// The maximum number of physical network cards that can be allocated to the
    /// instance.
    maximum_network_cards: ?i32 = null,

    /// The maximum number of network interfaces for the instance type.
    maximum_network_interfaces: ?i32 = null,

    /// The maximum number of secondary interfaces for the instance type.
    maximum_secondary_network_interfaces: ?i32 = null,

    /// Describes the network cards for the instance type.
    network_cards: ?[]const NetworkCardInfo = null,

    /// The network performance.
    network_performance: ?[]const u8 = null,

    /// Indicates whether secondary interface attachments from secondary network are
    /// supported.
    secondary_network_supported: ?bool = null,
};
