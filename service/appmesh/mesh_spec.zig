const EgressFilter = @import("egress_filter.zig").EgressFilter;
const MeshServiceDiscovery = @import("mesh_service_discovery.zig").MeshServiceDiscovery;

/// An object that represents the specification of a service mesh.
pub const MeshSpec = struct {
    /// The egress filter rules for the service mesh.
    egress_filter: ?EgressFilter,

    service_discovery: ?MeshServiceDiscovery,

    pub const json_field_names = .{
        .egress_filter = "egressFilter",
        .service_discovery = "serviceDiscovery",
    };
};
