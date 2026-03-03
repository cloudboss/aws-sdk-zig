const ClientAffinity = @import("client_affinity.zig").ClientAffinity;
const PortRange = @import("port_range.zig").PortRange;
const Protocol = @import("protocol.zig").Protocol;

/// A complex type for a listener.
pub const Listener = struct {
    /// Client affinity lets you direct all requests from a user to the same
    /// endpoint, if you have stateful applications,
    /// regardless of the port and protocol of the client request. Client affinity
    /// gives you control over whether to always
    /// route each client to the same specific endpoint.
    ///
    /// Global Accelerator uses a consistent-flow hashing algorithm to choose the
    /// optimal endpoint for a connection. If client
    /// affinity is `NONE`, Global Accelerator uses the "five-tuple" (5-tuple)
    /// properties—source IP address, source port,
    /// destination IP address, destination port, and protocol—to select the hash
    /// value, and then chooses the best
    /// endpoint. However, with this setting, if someone uses different ports to
    /// connect to Global Accelerator, their connections might not
    /// be always routed to the same endpoint because the hash value changes.
    ///
    /// If you want a given client to always be routed to the same endpoint, set
    /// client affinity to `SOURCE_IP`
    /// instead. When you use the `SOURCE_IP` setting, Global Accelerator uses the
    /// "two-tuple" (2-tuple) properties—
    /// source (client) IP address and destination IP address—to select the hash
    /// value.
    ///
    /// The default value is `NONE`.
    client_affinity: ?ClientAffinity = null,

    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: ?[]const u8 = null,

    /// The list of port ranges for the connections from clients to the accelerator.
    port_ranges: ?[]const PortRange = null,

    /// The protocol for the connections from clients to the accelerator.
    protocol: ?Protocol = null,

    pub const json_field_names = .{
        .client_affinity = "ClientAffinity",
        .listener_arn = "ListenerArn",
        .port_ranges = "PortRanges",
        .protocol = "Protocol",
    };
};
