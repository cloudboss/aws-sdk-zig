const VirtualGatewayConnectionPool = @import("virtual_gateway_connection_pool.zig").VirtualGatewayConnectionPool;
const VirtualGatewayHealthCheckPolicy = @import("virtual_gateway_health_check_policy.zig").VirtualGatewayHealthCheckPolicy;
const VirtualGatewayPortMapping = @import("virtual_gateway_port_mapping.zig").VirtualGatewayPortMapping;
const VirtualGatewayListenerTls = @import("virtual_gateway_listener_tls.zig").VirtualGatewayListenerTls;

/// An object that represents a listener for a virtual gateway.
pub const VirtualGatewayListener = struct {
    /// The connection pool information for the virtual gateway listener.
    connection_pool: ?VirtualGatewayConnectionPool = null,

    /// The health check information for the listener.
    health_check: ?VirtualGatewayHealthCheckPolicy = null,

    /// The port mapping information for the listener.
    port_mapping: VirtualGatewayPortMapping,

    /// A reference to an object that represents the Transport Layer Security (TLS)
    /// properties for the listener.
    tls: ?VirtualGatewayListenerTls = null,

    pub const json_field_names = .{
        .connection_pool = "connectionPool",
        .health_check = "healthCheck",
        .port_mapping = "portMapping",
        .tls = "tls",
    };
};
