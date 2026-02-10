const ModifyVerifiedAccessEndpointPortRange = @import("modify_verified_access_endpoint_port_range.zig").ModifyVerifiedAccessEndpointPortRange;
const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the options when modifying a Verified Access endpoint with the
/// `network-interface` type.
pub const ModifyVerifiedAccessEndpointEniOptions = struct {
    /// The IP port number.
    port: ?i32,

    /// The port ranges.
    port_ranges: ?[]const ModifyVerifiedAccessEndpointPortRange,

    /// The IP protocol.
    protocol: ?VerifiedAccessEndpointProtocol,
};
