const aws = @import("aws");

const NotVisibleMarker = @import("not_visible_marker.zig").NotVisibleMarker;
const FirewallSyncReason = @import("firewall_sync_reason.zig").FirewallSyncReason;

/// The out-of-sync reasons for a resource, or a marker indicating that the
/// details are not visible. Exactly one member is set.
pub const OutOfSyncReasonsView = union(enum) {
    /// Indicates that the details are not visible because of cross-account
    /// restrictions.
    not_visible: ?NotVisibleMarker,
    /// The out-of-sync reasons, keyed by firewall type.
    reasons: ?[]const aws.map.MapEntry(FirewallSyncReason),

    pub const json_field_names = .{
        .not_visible = "notVisible",
        .reasons = "reasons",
    };
};
