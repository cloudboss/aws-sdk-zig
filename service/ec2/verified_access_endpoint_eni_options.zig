const VerifiedAccessEndpointPortRange = @import("verified_access_endpoint_port_range.zig").VerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Options for a network-interface type endpoint.
pub const VerifiedAccessEndpointEniOptions = struct {
    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// The IP port number.
    port: ?i32,

    /// The port ranges.
    port_ranges: ?[]const VerifiedAccessEndpointPortRange,

    /// The IP protocol.
    protocol: ?VerifiedAccessEndpointProtocol,
};
