const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;

/// A mapping of a specific domain to a private endpoint for secure connectivity
/// through a VPC Lattice resource configuration.
pub const PrivateEndpointOverride = struct {
    /// The domain to override with a private endpoint.
    domain: []const u8,

    /// The private endpoint configuration for the specified domain.
    private_endpoint: PrivateEndpoint,

    pub const json_field_names = .{
        .domain = "domain",
        .private_endpoint = "privateEndpoint",
    };
};
