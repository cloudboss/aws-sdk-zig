const AcceptAction = @import("accept_action.zig").AcceptAction;

/// The structure of a traffic policy resource which is a container for policy
/// statements.
pub const TrafficPolicy = struct {
    /// Default action instructs the traﬃc policy to either Allow or Deny (block)
    /// messages that fall outside of (or not addressed by) the conditions of your
    /// policy statements
    default_action: AcceptAction,

    /// The identifier of the traffic policy resource.
    traffic_policy_id: []const u8,

    /// A user-friendly name of the traffic policy resource.
    traffic_policy_name: []const u8,

    pub const json_field_names = .{
        .default_action = "DefaultAction",
        .traffic_policy_id = "TrafficPolicyId",
        .traffic_policy_name = "TrafficPolicyName",
    };
};
