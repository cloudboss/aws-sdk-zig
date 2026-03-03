const EnaSrdUdpSpecificationRequest = @import("ena_srd_udp_specification_request.zig").EnaSrdUdpSpecificationRequest;

/// Defines Elastic Network Adapter (ENA) Scalable Reliable Datagram (SRD)
/// configuration.
pub const EnaSrdSpecificationRequest = struct {
    /// Enables or disables ENA SRD for network performance.
    ena_srd_enabled: ?bool = null,

    /// Configures UDP-specific ENA SRD settings.
    ena_srd_udp_specification: ?EnaSrdUdpSpecificationRequest = null,

    pub const json_field_names = .{
        .ena_srd_enabled = "EnaSrdEnabled",
        .ena_srd_udp_specification = "EnaSrdUdpSpecification",
    };
};
