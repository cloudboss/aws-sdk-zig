const CreateVerifiedAccessEndpointPortRange = @import("create_verified_access_endpoint_port_range.zig").CreateVerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the network interface options when creating an Amazon Web Services
/// Verified Access endpoint using the
/// `network-interface` type.
pub const CreateVerifiedAccessEndpointEniOptions = struct {
    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The IP port number.
    port: ?i32 = null,

    /// The port ranges.
    port_ranges: ?[]const CreateVerifiedAccessEndpointPortRange = null,

    /// The IP protocol.
    protocol: ?VerifiedAccessEndpointProtocol = null,
};
