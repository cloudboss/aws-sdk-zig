const ServiceNodePortRange = @import("service_node_port_range.zig").ServiceNodePortRange;

/// The Kubernetes API server configuration for an Amazon EKS cluster.
pub const KubeApiServerConfigResponse = struct {
    /// The duration that Kubernetes events are retained.
    event_ttl: ?[]const u8 = null,

    /// The port range for NodePort services.
    service_node_port_range: ?ServiceNodePortRange = null,

    pub const json_field_names = .{
        .event_ttl = "eventTtl",
        .service_node_port_range = "serviceNodePortRange",
    };
};
