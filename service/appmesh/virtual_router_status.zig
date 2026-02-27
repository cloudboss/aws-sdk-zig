const VirtualRouterStatusCode = @import("virtual_router_status_code.zig").VirtualRouterStatusCode;

/// An object that represents the status of a virtual router.
pub const VirtualRouterStatus = struct {
    /// The current status of the virtual router.
    status: VirtualRouterStatusCode,

    pub const json_field_names = .{
        .status = "status",
    };
};
