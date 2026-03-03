/// Represents the rejected events.
pub const RejectedLogEventsInfo = struct {
    /// The expired log events.
    expired_log_event_end_index: ?i32 = null,

    /// The index of the first log event that is too new. This field is inclusive.
    too_new_log_event_start_index: ?i32 = null,

    /// The index of the last log event that is too old. This field is exclusive.
    too_old_log_event_end_index: ?i32 = null,

    pub const json_field_names = .{
        .expired_log_event_end_index = "expiredLogEventEndIndex",
        .too_new_log_event_start_index = "tooNewLogEventStartIndex",
        .too_old_log_event_end_index = "tooOldLogEventEndIndex",
    };
};
