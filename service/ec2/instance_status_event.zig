const EventCode = @import("event_code.zig").EventCode;

/// Describes a scheduled event for an instance.
pub const InstanceStatusEvent = struct {
    /// The event code.
    code: ?EventCode = null,

    /// A description of the event.
    ///
    /// After a scheduled event is completed, it can still be described for up to a
    /// week. If
    /// the event has been completed, this description starts with the following
    /// text:
    /// [Completed].
    description: ?[]const u8 = null,

    /// The ID of the event.
    instance_event_id: ?[]const u8 = null,

    /// The latest scheduled end time for the event.
    not_after: ?i64 = null,

    /// The earliest scheduled start time for the event.
    not_before: ?i64 = null,

    /// The deadline for starting the event.
    not_before_deadline: ?i64 = null,
};
