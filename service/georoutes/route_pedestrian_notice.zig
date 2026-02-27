const RoutePedestrianNoticeCode = @import("route_pedestrian_notice_code.zig").RoutePedestrianNoticeCode;
const RouteNoticeImpact = @import("route_notice_impact.zig").RouteNoticeImpact;

/// Notices are additional information returned that indicate issues that
/// occurred during route calculation.
pub const RoutePedestrianNotice = struct {
    /// Code corresponding to the issue.
    code: RoutePedestrianNoticeCode,

    /// Impact corresponding to the issue. While Low impact notices can be safely
    /// ignored, High impact notices must be evaluated further to determine the
    /// impact.
    impact: ?RouteNoticeImpact,

    pub const json_field_names = .{
        .code = "Code",
        .impact = "Impact",
    };
};
