const ServiceNodePortRange = @import("service_node_port_range.zig").ServiceNodePortRange;

/// The configuration for the Kubernetes API server on an Amazon EKS cluster.
pub const KubeApiServerConfigRequest = struct {
    /// The duration that Kubernetes events are retained. Valid values are
    /// single-unit durations such as `30m` or `1h`.
    event_ttl: ?[]const u8 = null,

    /// The port range for NodePort services.
    service_node_port_range: ?ServiceNodePortRange = null,

    pub const json_field_names = .{
        .event_ttl = "eventTtl",
        .service_node_port_range = "serviceNodePortRange",
    };
};
