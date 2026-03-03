const LifeCycleLastLaunch = @import("life_cycle_last_launch.zig").LifeCycleLastLaunch;

/// An object representing the Source Server Lifecycle.
pub const LifeCycle = struct {
    /// The date and time of when the Source Server was added to the service.
    added_to_service_date_time: ?[]const u8 = null,

    /// The amount of time that the Source Server has been replicating for.
    elapsed_replication_duration: ?[]const u8 = null,

    /// The date and time of the first byte that was replicated from the Source
    /// Server.
    first_byte_date_time: ?[]const u8 = null,

    /// An object containing information regarding the last launch of the Source
    /// Server.
    last_launch: ?LifeCycleLastLaunch = null,

    /// The date and time this Source Server was last seen by the service.
    last_seen_by_service_date_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .added_to_service_date_time = "addedToServiceDateTime",
        .elapsed_replication_duration = "elapsedReplicationDuration",
        .first_byte_date_time = "firstByteDateTime",
        .last_launch = "lastLaunch",
        .last_seen_by_service_date_time = "lastSeenByServiceDateTime",
    };
};
