const GatewayStatus = @import("gateway_status.zig").GatewayStatus;

pub const DeleteGatewayResponse = struct {
    /// The unique identifier of the deleted gateway.
    gateway_id: []const u8,

    /// The current status of the gateway deletion.
    status: GatewayStatus,

    /// The reasons for the current status of the gateway deletion.
    status_reasons: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
        .status = "status",
        .status_reasons = "statusReasons",
    };
};
