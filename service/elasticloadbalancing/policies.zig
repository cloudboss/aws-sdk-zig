const AppCookieStickinessPolicy = @import("app_cookie_stickiness_policy.zig").AppCookieStickinessPolicy;
const LBCookieStickinessPolicy = @import("lb_cookie_stickiness_policy.zig").LBCookieStickinessPolicy;

/// The policies for a load balancer.
pub const Policies = struct {
    /// The stickiness policies created using CreateAppCookieStickinessPolicy.
    app_cookie_stickiness_policies: ?[]const AppCookieStickinessPolicy,

    /// The stickiness policies created using CreateLBCookieStickinessPolicy.
    lb_cookie_stickiness_policies: ?[]const LBCookieStickinessPolicy,

    /// The policies other than the stickiness policies.
    other_policies: ?[]const []const u8,
};
