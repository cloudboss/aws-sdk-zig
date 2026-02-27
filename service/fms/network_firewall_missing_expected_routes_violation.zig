const ExpectedRoute = @import("expected_route.zig").ExpectedRoute;

/// Violation detail for an expected route missing in Network Firewall.
pub const NetworkFirewallMissingExpectedRoutesViolation = struct {
    /// The expected routes.
    expected_routes: ?[]const ExpectedRoute,

    /// The target of the violation.
    violation_target: ?[]const u8,

    /// Information about the VPC ID.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .expected_routes = "ExpectedRoutes",
        .violation_target = "ViolationTarget",
        .vpc_id = "VpcId",
    };
};
