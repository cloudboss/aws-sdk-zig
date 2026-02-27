const AwsElbAppCookieStickinessPolicy = @import("aws_elb_app_cookie_stickiness_policy.zig").AwsElbAppCookieStickinessPolicy;
const AwsElbLbCookieStickinessPolicy = @import("aws_elb_lb_cookie_stickiness_policy.zig").AwsElbLbCookieStickinessPolicy;

/// Contains information about the policies for a load balancer.
pub const AwsElbLoadBalancerPolicies = struct {
    /// The stickiness policies that are created using
    /// `CreateAppCookieStickinessPolicy`.
    app_cookie_stickiness_policies: ?[]const AwsElbAppCookieStickinessPolicy,

    /// The stickiness policies that are created using
    /// `CreateLBCookieStickinessPolicy`.
    lb_cookie_stickiness_policies: ?[]const AwsElbLbCookieStickinessPolicy,

    /// The policies other than the stickiness policies.
    other_policies: ?[]const []const u8,

    pub const json_field_names = .{
        .app_cookie_stickiness_policies = "AppCookieStickinessPolicies",
        .lb_cookie_stickiness_policies = "LbCookieStickinessPolicies",
        .other_policies = "OtherPolicies",
    };
};
