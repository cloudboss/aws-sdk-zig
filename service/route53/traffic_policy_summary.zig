const RRType = @import("rr_type.zig").RRType;

/// A complex type that contains information about the latest version of one
/// traffic
/// policy that is associated with the current Amazon Web Services account.
pub const TrafficPolicySummary = struct {
    /// The ID that Amazon Route 53 assigned to the traffic policy when you created
    /// it.
    id: []const u8,

    /// The version number of the latest version of the traffic policy.
    latest_version: i32,

    /// The name that you specified for the traffic policy when you created it.
    name: []const u8,

    /// The number of traffic policies that are associated with the current Amazon
    /// Web Services account.
    traffic_policy_count: i32,

    /// The DNS type of the resource record sets that Amazon Route 53 creates when
    /// you use a
    /// traffic policy to create a traffic policy instance.
    @"type": RRType,
};
