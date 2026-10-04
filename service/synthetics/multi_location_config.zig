const LocationType = @import("location_type.zig").LocationType;
const Replica = @import("replica.zig").Replica;
const ReplicationState = @import("replication_state.zig").ReplicationState;

/// A structure that contains information about the multi-location configuration
/// of a canary, including whether it is a primary or replica, the primary
/// location, and the list of replicas.
pub const MultiLocationConfig = struct {
    /// Indicates whether this canary is the `Primary` or a `Replica` in the
    /// multi-location configuration.
    location_type: ?LocationType = null,

    /// The Amazon Web Services Region where the primary canary is located.
    primary_location: ?[]const u8 = null,

    /// A list of replicas for this canary. This field is present only for the
    /// primary location canary.
    replicas: ?[]const Replica = null,

    /// The overall replication state of the canary across all replica locations.
    /// This field is present only for the primary location canary. Valid values are
    /// `InProgress`, `InSync`, and `Inconsistent`.
    replication_state: ?ReplicationState = null,

    pub const json_field_names = .{
        .location_type = "LocationType",
        .primary_location = "PrimaryLocation",
        .replicas = "Replicas",
        .replication_state = "ReplicationState",
    };
};
