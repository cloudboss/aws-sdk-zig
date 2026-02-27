/// The types of events that are sent to the event destination.
pub const EventType = enum {
    initiated_call,
    ringing,
    answered,
    completed_call,
    busy,
    failed,
    no_answer,

    pub const json_field_names = .{
        .initiated_call = "INITIATED_CALL",
        .ringing = "RINGING",
        .answered = "ANSWERED",
        .completed_call = "COMPLETED_CALL",
        .busy = "BUSY",
        .failed = "FAILED",
        .no_answer = "NO_ANSWER",
    };
};
