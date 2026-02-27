const NetworkDirection = @import("network_direction.zig").NetworkDirection;
const PortRange = @import("port_range.zig").PortRange;

/// The details of network-related information about a finding.
pub const Network = struct {
    /// The destination domain of network-related information about a finding.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 128.
    destination_domain: ?[]const u8,

    /// The destination IPv4 address of network-related information about a finding.
    destination_ip_v4: ?[]const u8,

    /// The destination IPv6 address of network-related information about a finding.
    destination_ip_v6: ?[]const u8,

    /// The destination port of network-related information about a finding.
    destination_port: ?i32,

    /// The direction of network traffic associated with a finding.
    direction: ?NetworkDirection,

    /// The range of open ports that is present on the network.
    open_port_range: ?PortRange,

    /// The protocol of network-related information about a finding.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 16.
    protocol: ?[]const u8,

    /// The source domain of network-related information about a finding.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 128.
    source_domain: ?[]const u8,

    /// The source IPv4 address of network-related information about a finding.
    source_ip_v4: ?[]const u8,

    /// The source IPv6 address of network-related information about a finding.
    source_ip_v6: ?[]const u8,

    /// The source media access control (MAC) address of network-related information
    /// about a
    /// finding.
    source_mac: ?[]const u8,

    /// The source port of network-related information about a finding.
    source_port: ?i32,

    pub const json_field_names = .{
        .destination_domain = "DestinationDomain",
        .destination_ip_v4 = "DestinationIpV4",
        .destination_ip_v6 = "DestinationIpV6",
        .destination_port = "DestinationPort",
        .direction = "Direction",
        .open_port_range = "OpenPortRange",
        .protocol = "Protocol",
        .source_domain = "SourceDomain",
        .source_ip_v4 = "SourceIpV4",
        .source_ip_v6 = "SourceIpV6",
        .source_mac = "SourceMac",
        .source_port = "SourcePort",
    };
};
