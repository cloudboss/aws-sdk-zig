const EventCode = @import("event_code.zig").EventCode;

/// Describes a scheduled event for an instance.
pub const InstanceStatusEvent = struct {
    /// The event code.
    code: ?EventCode,

    /// A description of the event.
    ///
    /// After a scheduled event is completed, it can still be described for up to a
    /// week. If
    /// the event has been completed, this description starts with the following
    /// text:
    /// [Completed].
    description: ?[]const u8,

    /// The ID of the event.
    instance_event_id: ?[]const u8,

    /// The latest scheduled end time for the event.
    not_after: ?i64,

    /// The earliest scheduled start time for the event.
    not_before: ?i64,

    /// The deadline for starting the event.
    not_before_deadline: ?i64,
};
