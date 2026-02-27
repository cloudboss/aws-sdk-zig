const VirtualGatewayStatusCode = @import("virtual_gateway_status_code.zig").VirtualGatewayStatusCode;

/// An object that represents the status of the mesh resource.
pub const VirtualGatewayStatus = struct {
    /// The current status.
    status: VirtualGatewayStatusCode,

    pub const json_field_names = .{
        .status = "status",
    };
};
