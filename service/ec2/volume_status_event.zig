/// Describes a volume status event.
pub const VolumeStatusEvent = struct {
    /// A description of the event.
    description: ?[]const u8 = null,

    /// The ID of this event.
    event_id: ?[]const u8 = null,

    /// The type of this event.
    event_type: ?[]const u8 = null,

    /// The ID of the instance associated with the event.
    instance_id: ?[]const u8 = null,

    /// The latest end time of the event.
    not_after: ?i64 = null,

    /// The earliest start time of the event.
    not_before: ?i64 = null,
};
