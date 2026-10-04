const RouteTaxiNoticeCode = @import("route_taxi_notice_code.zig").RouteTaxiNoticeCode;
const RouteNoticeImpact = @import("route_notice_impact.zig").RouteNoticeImpact;

/// A notice that indicates an issue that occurred during route calculation.
pub const RouteTaxiNotice = struct {
    /// Code corresponding to the issue.
    code: RouteTaxiNoticeCode,

    /// Impact corresponding to the issue. While Low impact notices can be safely
    /// ignored, High impact notices must be evaluated further to determine the
    /// impact.
    impact: ?RouteNoticeImpact = null,

    pub const json_field_names = .{
        .code = "Code",
        .impact = "Impact",
    };
};
