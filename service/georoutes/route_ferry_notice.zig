const RouteFerryNoticeCode = @import("route_ferry_notice_code.zig").RouteFerryNoticeCode;
const RouteNoticeImpact = @import("route_notice_impact.zig").RouteNoticeImpact;

/// Notices are additional information returned that indicate issues that
/// occurred during route calculation.
pub const RouteFerryNotice = struct {
    /// Code corresponding to the issue.
    code: RouteFerryNoticeCode,

    /// Impact corresponding to the issue. While Low impact notices can be safely
    /// ignored, High impact notices must be evaluated further to determine the
    /// impact.
    impact: ?RouteNoticeImpact,

    pub const json_field_names = .{
        .code = "Code",
        .impact = "Impact",
    };
};
