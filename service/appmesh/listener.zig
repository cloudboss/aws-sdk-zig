const VirtualNodeConnectionPool = @import("virtual_node_connection_pool.zig").VirtualNodeConnectionPool;
const HealthCheckPolicy = @import("health_check_policy.zig").HealthCheckPolicy;
const OutlierDetection = @import("outlier_detection.zig").OutlierDetection;
const PortMapping = @import("port_mapping.zig").PortMapping;
const ListenerTimeout = @import("listener_timeout.zig").ListenerTimeout;
const ListenerTls = @import("listener_tls.zig").ListenerTls;

/// An object that represents a listener for a virtual node.
pub const Listener = struct {
    /// The connection pool information for the listener.
    connection_pool: ?VirtualNodeConnectionPool = null,

    /// The health check information for the listener.
    health_check: ?HealthCheckPolicy = null,

    /// The outlier detection information for the listener.
    outlier_detection: ?OutlierDetection = null,

    /// The port mapping information for the listener.
    port_mapping: PortMapping,

    /// An object that represents timeouts for different protocols.
    timeout: ?ListenerTimeout = null,

    /// A reference to an object that represents the Transport Layer Security (TLS)
    /// properties for a listener.
    tls: ?ListenerTls = null,

    pub const json_field_names = .{
        .connection_pool = "connectionPool",
        .health_check = "healthCheck",
        .outlier_detection = "outlierDetection",
        .port_mapping = "portMapping",
        .timeout = "timeout",
        .tls = "tls",
    };
};
