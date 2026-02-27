/// Information about the target group stickiness for a rule.
pub const TargetGroupStickinessConfig = struct {
    /// [Application Load Balancers] The time period, in seconds, during which
    /// requests from a
    /// client should be routed to the same target group. The range is 1-604800
    /// seconds (7 days). You
    /// must specify this value when enabling target group stickiness.
    duration_seconds: ?i32,

    /// Indicates whether target group stickiness is enabled.
    enabled: ?bool,
};
