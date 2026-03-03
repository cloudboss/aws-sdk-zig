/// Describes the network card support of the instance type.
pub const NetworkCardInfo = struct {
    /// The number of additional network interfaces that can be attached to an
    /// instance when using
    /// flexible Elastic Network Adapter (ENA) queues. This number is in addition to
    /// the base number
    /// specified by `maximumNetworkInterfaces`.
    additional_flexible_network_interfaces: ?i32 = null,

    /// The baseline network performance of the network card, in Gbps.
    baseline_bandwidth_in_gbps: ?f64 = null,

    /// The default number of the ENA queues for each interface.
    default_ena_queue_count_per_interface: ?i32 = null,

    /// The maximum number of the ENA queues.
    maximum_ena_queue_count: ?i32 = null,

    /// The maximum number of the ENA queues for each interface.
    maximum_ena_queue_count_per_interface: ?i32 = null,

    /// The maximum number of network interfaces for the network card.
    maximum_network_interfaces: ?i32 = null,

    /// The index of the network card.
    network_card_index: ?i32 = null,

    /// The network performance of the network card.
    network_performance: ?[]const u8 = null,

    /// The peak (burst) network performance of the network card, in Gbps.
    peak_bandwidth_in_gbps: ?f64 = null,
};
