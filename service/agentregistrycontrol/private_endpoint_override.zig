const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;

/// A mapping of a domain to the private endpoint used to reach it.
pub const PrivateEndpointOverride = struct {
    /// The domain name to which this private endpoint override applies.
    domain: []const u8,

    /// The private endpoint used to reach the specified domain.
    private_endpoint: PrivateEndpoint,

    pub const json_field_names = .{
        .domain = "domain",
        .private_endpoint = "privateEndpoint",
    };
};
