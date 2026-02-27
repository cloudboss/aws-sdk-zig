const RRType = @import("rr_type.zig").RRType;

/// A complex type that contains settings for a traffic policy.
pub const TrafficPolicy = struct {
    /// The comment that you specify in the `CreateTrafficPolicy` request, if
    /// any.
    comment: ?[]const u8,

    /// The definition of a traffic policy in JSON format. You specify the JSON
    /// document to
    /// use for a new traffic policy in the `CreateTrafficPolicy` request. For more
    /// information about the JSON format, see [Traffic Policy Document
    /// Format](https://docs.aws.amazon.com/Route53/latest/APIReference/api-policies-traffic-policy-document-format.html).
    document: []const u8,

    /// The ID that Amazon Route 53 assigned to a traffic policy when you created
    /// it.
    id: []const u8,

    /// The name that you specified when you created the traffic policy.
    name: []const u8,

    /// The DNS type of the resource record sets that Amazon Route 53 creates when
    /// you use a
    /// traffic policy to create a traffic policy instance.
    type: RRType,

    /// The version number that Amazon Route 53 assigns to a traffic policy. For a
    /// new traffic
    /// policy, the value of `Version` is always 1.
    version: i32,
};
