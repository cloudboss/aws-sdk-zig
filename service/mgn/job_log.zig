const JobLogEvent = @import("job_log_event.zig").JobLogEvent;
const JobLogEventData = @import("job_log_event_data.zig").JobLogEventData;

/// Job log.
pub const JobLog = struct {
    /// Job log event.
    event: ?JobLogEvent,

    /// Job event data
    event_data: ?JobLogEventData,

    /// Job log event date and time.
    log_date_time: ?[]const u8,

    pub const json_field_names = .{
        .event = "event",
        .event_data = "eventData",
        .log_date_time = "logDateTime",
    };
};
