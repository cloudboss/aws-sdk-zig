const EnaSrdUdpSpecificationRequest = @import("ena_srd_udp_specification_request.zig").EnaSrdUdpSpecificationRequest;

/// Launch instances with ENA Express settings configured from your launch
/// template.
pub const EnaSrdSpecificationRequest = struct {
    /// Specifies whether ENA Express is enabled for the network interface when you
    /// launch an
    /// instance.
    ena_srd_enabled: ?bool = null,

    /// Contains ENA Express settings for UDP network traffic for the network
    /// interface
    /// attached to the instance.
    ena_srd_udp_specification: ?EnaSrdUdpSpecificationRequest = null,
};
