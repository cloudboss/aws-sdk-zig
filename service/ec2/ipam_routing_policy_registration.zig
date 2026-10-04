const IpamRoutingPolicyRegistrationState = @import("ipam_routing_policy_registration_state.zig").IpamRoutingPolicyRegistrationState;

/// Contains information about a routing policy registration that represents a
/// Route Origin Authorization (ROA) managed through IPAM.
pub const IpamRoutingPolicyRegistration = struct {
    /// The Autonomous System Numbers (ASNs) authorized to originate the prefix.
    asns: ?[]const []const u8 = null,

    /// The IP address prefix in CIDR notation authorized by the ROA.
    cidr: ?[]const u8 = null,

    /// The description of the routing policy registration.
    description: ?[]const u8 = null,

    /// The ID of the most recent delta that modified this registration.
    latest_delta_id: ?[]const u8 = null,

    /// The maximum prefix length that the ASNs are authorized to announce.
    max_length: ?i32 = null,

    /// Specifies whether to permit more specific route announcements than the CIDR
    /// prefix. When enabled, ASNs can announce sub-prefixes of the authorized CIDR
    /// up to the specified maximum length. Default: `false`.
    permit_more_specific_announcements: ?bool = null,

    /// The state of the routing policy registration. Valid values:
    /// `pending-activate` | `activate-failed` | `create-in-progress` |
    /// `create-complete` | `update-in-progress` | `update-complete` |
    /// `delete-in-progress` | `delete-complete`.
    state: ?IpamRoutingPolicyRegistrationState = null,
};
