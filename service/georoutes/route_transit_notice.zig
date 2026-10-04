const RouteTransitNoticeCode = @import("route_transit_notice_code.zig").RouteTransitNoticeCode;
const RouteNoticeImpact = @import("route_notice_impact.zig").RouteNoticeImpact;

/// A notice that indicates an issue that occurred during route calculation.
pub const RouteTransitNotice = struct {
    /// Code corresponding to the issue.
    code: RouteTransitNoticeCode,

    /// Impact corresponding to the issue. While Low impact notices can be safely
    /// ignored, High impact notices must be evaluated further to determine the
    /// impact.
    impact: ?RouteNoticeImpact = null,

    pub const json_field_names = .{
        .code = "Code",
        .impact = "Impact",
    };
};
