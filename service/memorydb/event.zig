const SourceType = @import("source_type.zig").SourceType;

/// Represents a single occurrence of something interesting within the system.
/// Some examples of events are creating a cluster or adding or removing a
/// node.
pub const Event = struct {
    /// The date and time when the event occurred.
    date: ?i64,

    /// The text of the event.
    message: ?[]const u8,

    /// The name for the source of the event. For example, if the event occurred at
    /// the cluster level, the identifier would be the name of the cluster.
    source_name: ?[]const u8,

    /// Specifies the origin of this event - a cluster, a parameter group, a
    /// security group, etc.
    source_type: ?SourceType,

    pub const json_field_names = .{
        .date = "Date",
        .message = "Message",
        .source_name = "SourceName",
        .source_type = "SourceType",
    };
};
