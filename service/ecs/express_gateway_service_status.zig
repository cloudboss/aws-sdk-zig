const ExpressGatewayServiceStatusCode = @import("express_gateway_service_status_code.zig").ExpressGatewayServiceStatusCode;

/// An object that defines the status of Express service creation and
/// information about the status of the service.
pub const ExpressGatewayServiceStatus = struct {
    /// The status of the Express service.
    status_code: ?ExpressGatewayServiceStatusCode = null,

    /// Information about why the Express service is in the current status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
