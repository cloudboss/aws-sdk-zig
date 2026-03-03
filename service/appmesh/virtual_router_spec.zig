const VirtualRouterListener = @import("virtual_router_listener.zig").VirtualRouterListener;

/// An object that represents the specification of a virtual router.
pub const VirtualRouterSpec = struct {
    /// The listeners that the virtual router is expected to receive inbound traffic
    /// from. You
    /// can specify one listener.
    listeners: ?[]const VirtualRouterListener = null,

    pub const json_field_names = .{
        .listeners = "listeners",
    };
};
