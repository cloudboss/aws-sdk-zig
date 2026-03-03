const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const InternetFallbackProtocol = @import("internet_fallback_protocol.zig").InternetFallbackProtocol;

/// Describes the access endpoint configuration for a WorkSpace.
pub const AccessEndpointConfig = struct {
    /// Indicates a list of access endpoints associated with this directory.
    access_endpoints: []const AccessEndpoint,

    /// Indicates a list of protocols that fallback to using the public Internet
    /// when streaming over a VPC endpoint is not available.
    internet_fallback_protocols: ?[]const InternetFallbackProtocol = null,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .internet_fallback_protocols = "InternetFallbackProtocols",
    };
};
