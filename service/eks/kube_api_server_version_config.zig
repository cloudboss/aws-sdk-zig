const DurationParameterConfig = @import("duration_parameter_config.zig").DurationParameterConfig;
const PortRangeParameterConfig = @import("port_range_parameter_config.zig").PortRangeParameterConfig;

/// The Kubernetes API server version-specific configuration defaults and
/// constraints.
pub const KubeApiServerVersionConfig = struct {
    /// The event TTL configuration with default value and constraints.
    event_ttl: ?DurationParameterConfig = null,

    /// The service node port range configuration with default value and
    /// constraints.
    service_node_port_range: ?PortRangeParameterConfig = null,

    pub const json_field_names = .{
        .event_ttl = "eventTtl",
        .service_node_port_range = "serviceNodePortRange",
    };
};
