/// ENA Express is compatible with both TCP and UDP transport protocols. When
/// it's enabled, TCP traffic
/// automatically uses it. However, some UDP-based applications are designed to
/// handle network packets that are
/// out of order, without a need for retransmission, such as live video
/// broadcasting or other near-real-time
/// applications. For UDP traffic, you can specify whether to use ENA Express,
/// based on your application
/// environment needs.
pub const LaunchTemplateEnaSrdUdpSpecification = struct {
    /// Indicates whether UDP traffic to and from the instance uses ENA Express. To
    /// specify this setting,
    /// you must first enable ENA Express.
    ena_srd_udp_enabled: ?bool = null,
};
