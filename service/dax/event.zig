const SourceType = @import("source_type.zig").SourceType;

/// Represents a single occurrence of something interesting within the system.
/// Some
/// examples of events are creating a DAX cluster, adding or removing a node, or
/// rebooting a
/// node.
pub const Event = struct {
    /// The date and time when the event occurred.
    date: ?i64,

    /// A user-defined message associated with the event.
    message: ?[]const u8,

    /// The source of the event. For example, if the event occurred at the node
    /// level, the
    /// source would be the node ID.
    source_name: ?[]const u8,

    /// Specifies the origin of this event - a cluster, a parameter group, a node
    /// ID,
    /// etc.
    source_type: ?SourceType,

    pub const json_field_names = .{
        .date = "Date",
        .message = "Message",
        .source_name = "SourceName",
        .source_type = "SourceType",
    };
};
