const VirtualGatewayBackendDefaults = @import("virtual_gateway_backend_defaults.zig").VirtualGatewayBackendDefaults;
const VirtualGatewayListener = @import("virtual_gateway_listener.zig").VirtualGatewayListener;
const VirtualGatewayLogging = @import("virtual_gateway_logging.zig").VirtualGatewayLogging;

/// An object that represents the specification of a service mesh resource.
pub const VirtualGatewaySpec = struct {
    /// A reference to an object that represents the defaults for backends.
    backend_defaults: ?VirtualGatewayBackendDefaults = null,

    /// The listeners that the mesh endpoint is expected to receive inbound traffic
    /// from. You
    /// can specify one listener.
    listeners: []const VirtualGatewayListener,

    logging: ?VirtualGatewayLogging = null,

    pub const json_field_names = .{
        .backend_defaults = "backendDefaults",
        .listeners = "listeners",
        .logging = "logging",
    };
};
