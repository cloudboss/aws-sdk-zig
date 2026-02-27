const aws = @import("aws");

const AddressFamily = @import("address_family.zig").AddressFamily;
const Protocol = @import("protocol.zig").Protocol;
const ProbeState = @import("probe_state.zig").ProbeState;

/// Describes information about a network monitor probe.
pub const Probe = struct {
    /// The IPv4 or IPv6 address for the probe.
    address_family: ?AddressFamily,

    /// The time and date the probe was created.
    created_at: ?i64,

    /// The destination for the probe. This should be either an `IPV4` or `IPV6`.
    destination: []const u8,

    /// The destination port for the probe. This is required only if the `protocol`
    /// is `TCP` and must be a number between `1` and `65536`.
    destination_port: ?i32,

    /// The time and date that the probe was last modified.
    modified_at: ?i64,

    /// The size of the packets traveling between the `source` and `destination`.
    /// This must be a number between `56` and
    packet_size: ?i32,

    /// The ARN of the probe.
    probe_arn: ?[]const u8,

    /// The ID of the probe.
    probe_id: ?[]const u8,

    /// The network protocol for the destination. This can be either `TCP` or
    /// `ICMP`. If the protocol is `TCP`, then `port` is also required.
    protocol: Protocol,

    /// The ARN of the probe source subnet.
    source_arn: []const u8,

    /// The state of the probe.
    state: ?ProbeState,

    /// The list of key-value pairs created and assigned to the probe.
    tags: ?[]const aws.map.StringMapEntry,

    /// The ID of the source VPC subnet.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .created_at = "createdAt",
        .destination = "destination",
        .destination_port = "destinationPort",
        .modified_at = "modifiedAt",
        .packet_size = "packetSize",
        .probe_arn = "probeArn",
        .probe_id = "probeId",
        .protocol = "protocol",
        .source_arn = "sourceArn",
        .state = "state",
        .tags = "tags",
        .vpc_id = "vpcId",
    };
};
