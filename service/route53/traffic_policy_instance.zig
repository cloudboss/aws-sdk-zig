const RRType = @import("rr_type.zig").RRType;

/// A complex type that contains settings for the new traffic policy instance.
pub const TrafficPolicyInstance = struct {
    /// The ID of the hosted zone that Amazon Route 53 created resource record sets
    /// in.
    hosted_zone_id: []const u8,

    /// The ID that Amazon Route 53 assigned to the new traffic policy instance.
    id: []const u8,

    /// If `State` is `Failed`, an explanation of the reason for the
    /// failure. If `State` is another value, `Message` is empty.
    message: []const u8,

    /// The DNS name, such as www.example.com, for which Amazon Route 53 responds to
    /// queries
    /// by using the resource record sets that are associated with this traffic
    /// policy instance.
    name: []const u8,

    /// The value of `State` is one of the following values:
    ///
    /// **Applied**
    ///
    /// Amazon Route 53 has finished creating resource record sets, and changes
    /// have propagated to all Route 53 edge locations.
    ///
    /// **Creating**
    ///
    /// Route 53 is creating the resource record sets. Use
    /// `GetTrafficPolicyInstance` to confirm that the
    /// `CreateTrafficPolicyInstance` request completed
    /// successfully.
    ///
    /// **Failed**
    ///
    /// Route 53 wasn't able to create or update the resource record sets. When
    /// the value of `State` is `Failed`, see
    /// `Message` for an explanation of what caused the request to
    /// fail.
    state: []const u8,

    /// The ID of the traffic policy that Amazon Route 53 used to create resource
    /// record sets
    /// in the specified hosted zone.
    traffic_policy_id: []const u8,

    /// The DNS type that Amazon Route 53 assigned to all of the resource record
    /// sets that it
    /// created for this traffic policy instance.
    traffic_policy_type: RRType,

    /// The version of the traffic policy that Amazon Route 53 used to create
    /// resource record
    /// sets in the specified hosted zone.
    traffic_policy_version: i32,

    /// The TTL that Amazon Route 53 assigned to all of the resource record sets
    /// that it
    /// created in the specified hosted zone.
    ttl: i64,
};
