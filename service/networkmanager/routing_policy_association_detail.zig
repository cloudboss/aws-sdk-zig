/// Information about a routing policy association.
pub const RoutingPolicyAssociationDetail = struct {
    /// The names of the routing policies in the association.
    routing_policy_names: ?[]const []const u8 = null,

    /// The names of the segments that are shared with each other in the
    /// association.
    shared_segments: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .routing_policy_names = "RoutingPolicyNames",
        .shared_segments = "SharedSegments",
    };
};
