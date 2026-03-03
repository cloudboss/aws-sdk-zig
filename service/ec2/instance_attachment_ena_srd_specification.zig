const InstanceAttachmentEnaSrdUdpSpecification = @import("instance_attachment_ena_srd_udp_specification.zig").InstanceAttachmentEnaSrdUdpSpecification;

/// ENA Express uses Amazon Web Services Scalable Reliable Datagram (SRD)
/// technology to increase the
/// maximum bandwidth used per stream and minimize tail latency of network
/// traffic between EC2 instances.
/// With ENA Express, you can communicate between two EC2 instances in the same
/// subnet within the same
/// account, or in different accounts. Both sending and receiving instances must
/// have ENA Express enabled.
///
/// To improve the reliability of network packet delivery, ENA Express reorders
/// network packets on the
/// receiving end by default. However, some UDP-based applications are designed
/// to handle network packets
/// that are out of order to reduce the overhead for packet delivery at the
/// network layer. When ENA Express
/// is enabled, you can specify whether UDP network traffic uses it.
pub const InstanceAttachmentEnaSrdSpecification = struct {
    /// Indicates whether ENA Express is enabled for the network interface.
    ena_srd_enabled: ?bool = null,

    /// Configures ENA Express for UDP network traffic.
    ena_srd_udp_specification: ?InstanceAttachmentEnaSrdUdpSpecification = null,
};
