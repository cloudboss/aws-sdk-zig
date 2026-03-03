const RouteVehicleNoticeCode = @import("route_vehicle_notice_code.zig").RouteVehicleNoticeCode;
const RouteVehicleNoticeDetail = @import("route_vehicle_notice_detail.zig").RouteVehicleNoticeDetail;
const RouteNoticeImpact = @import("route_notice_impact.zig").RouteNoticeImpact;

/// Notices are additional information returned that indicate issues that
/// occurred during route calculation.
pub const RouteVehicleNotice = struct {
    /// Code corresponding to the issue.
    code: RouteVehicleNoticeCode,

    /// Additional details of the notice.
    details: []const RouteVehicleNoticeDetail,

    /// Impact corresponding to the issue. While Low impact notices can be safely
    /// ignored, High impact notices must be evaluated further to determine the
    /// impact.
    impact: ?RouteNoticeImpact = null,

    pub const json_field_names = .{
        .code = "Code",
        .details = "Details",
        .impact = "Impact",
    };
};
