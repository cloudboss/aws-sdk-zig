const ReplicationStatusType = @import("replication_status_type.zig").ReplicationStatusType;

/// Represents the status of the replication of an application to a location. An
/// application cannot be streamed from a location until it has finished
/// replicating there.
pub const ReplicationStatus = struct {
    /// A location's name. For example, `us-east-1`. For a complete list of
    /// locations that Amazon GameLift Streams supports, refer to [Regions, quotas,
    /// and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    location: ?[]const u8 = null,

    /// The current status of the replication process.
    status: ?ReplicationStatusType = null,

    pub const json_field_names = .{
        .location = "Location",
        .status = "Status",
    };
};
