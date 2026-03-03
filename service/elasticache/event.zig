const SourceType = @import("source_type.zig").SourceType;

/// Represents a single occurrence of something interesting within the system.
/// Some
/// examples of events are creating a cluster, adding or removing a cache node,
/// or rebooting
/// a node.
pub const Event = struct {
    /// The date and time when the event occurred.
    date: ?i64 = null,

    /// The text of the event.
    message: ?[]const u8 = null,

    /// The identifier for the source of the event. For example, if the event
    /// occurred at the
    /// cluster level, the identifier would be the name of the cluster.
    source_identifier: ?[]const u8 = null,

    /// Specifies the origin of this event - a cluster, a parameter group, a
    /// security group,
    /// etc.
    source_type: ?SourceType = null,
};
