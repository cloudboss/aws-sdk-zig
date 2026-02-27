const BackendDefaults = @import("backend_defaults.zig").BackendDefaults;
const Backend = @import("backend.zig").Backend;
const Listener = @import("listener.zig").Listener;
const Logging = @import("logging.zig").Logging;
const ServiceDiscovery = @import("service_discovery.zig").ServiceDiscovery;

/// An object that represents the specification of a virtual node.
pub const VirtualNodeSpec = struct {
    /// A reference to an object that represents the defaults for backends.
    backend_defaults: ?BackendDefaults,

    /// The backends that the virtual node is expected to send outbound traffic to.
    backends: ?[]const Backend,

    /// The listener that the virtual node is expected to receive inbound traffic
    /// from. You can
    /// specify one listener.
    listeners: ?[]const Listener,

    /// The inbound and outbound access logging information for the virtual node.
    logging: ?Logging,

    /// The service discovery information for the virtual node. If your virtual node
    /// does not
    /// expect ingress traffic, you can omit this parameter. If you specify a
    /// `listener`, then you must specify service discovery information.
    service_discovery: ?ServiceDiscovery,

    pub const json_field_names = .{
        .backend_defaults = "backendDefaults",
        .backends = "backends",
        .listeners = "listeners",
        .logging = "logging",
        .service_discovery = "serviceDiscovery",
    };
};
