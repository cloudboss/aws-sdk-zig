const VirtualServiceStatusCode = @import("virtual_service_status_code.zig").VirtualServiceStatusCode;

/// An object that represents the status of a virtual service.
pub const VirtualServiceStatus = struct {
    /// The current status of the virtual service.
    status: VirtualServiceStatusCode,

    pub const json_field_names = .{
        .status = "status",
    };
};
