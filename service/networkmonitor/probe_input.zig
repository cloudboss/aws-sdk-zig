const aws = @import("aws");

const Protocol = @import("protocol.zig").Protocol;

/// Defines a probe when creating a probe or monitor.
pub const ProbeInput = struct {
    /// The destination IP address. This must be either `IPV4` or `IPV6`.
    destination: []const u8,

    /// The port associated with the `destination`. This is required only if the
    /// `protocol` is `TCP` and must be a number between `1` and `65536`.
    destination_port: ?i32,

    /// The size of the packets sent between the source and destination. This must
    /// be a number between `56` and `8500`.
    packet_size: ?i32,

    /// The protocol used for the network traffic between the `source` and
    /// `destination`. This must be either `TCP` or `ICMP`.
    protocol: Protocol,

    /// The ARN of the subnet.
    source_arn: []const u8,

    /// The list of key-value pairs created and assigned to the monitor.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .destination = "destination",
        .destination_port = "destinationPort",
        .packet_size = "packetSize",
        .protocol = "protocol",
        .source_arn = "sourceArn",
        .tags = "tags",
    };
};
