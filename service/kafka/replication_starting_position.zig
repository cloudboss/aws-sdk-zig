const ReplicationStartingPositionType = @import("replication_starting_position_type.zig").ReplicationStartingPositionType;

/// Configuration for specifying the position in the topics to start replicating
/// from.
pub const ReplicationStartingPosition = struct {
    /// The type of replication starting position.
    type: ?ReplicationStartingPositionType,

    pub const json_field_names = .{
        .type = "Type",
    };
};
