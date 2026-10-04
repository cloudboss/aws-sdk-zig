const IpamRoutingPolicyRegistrationDeltaState = @import("ipam_routing_policy_registration_delta_state.zig").IpamRoutingPolicyRegistrationDeltaState;

/// Contains information about a routing policy registration change, including
/// the changes applied and their publication state.
pub const IpamRoutingPolicyRegistrationDelta = struct {
    /// The unique identifier of the delta.
    delta_id: ?[]const u8 = null,

    /// The JSON specification describing the changes applied in this delta.
    delta_json: ?[]const u8 = null,

    /// The state of the delta. Valid values: `pending` | `published` | `failed`.
    state: ?IpamRoutingPolicyRegistrationDeltaState = null,

    /// A message describing the current state, including error information if the
    /// delta failed.
    state_message: ?[]const u8 = null,
};
