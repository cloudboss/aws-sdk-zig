/// Settings for a SCTE-35 splice_insert message.
pub const Scte35SpliceInsertScheduleActionSettings = struct {
    /// Optional, the duration for the splice_insert, in 90 KHz ticks. To convert
    /// seconds to ticks, multiple the seconds by 90,000. If you enter a duration,
    /// there is an expectation that the downstream system can read the duration and
    /// cue in at that time. If you do not enter a duration, the splice_insert will
    /// continue indefinitely and there is an expectation that you will enter a
    /// return_to_network to end the splice_insert at the appropriate time.
    duration: ?i64 = null,

    /// The splice_event_id for the SCTE-35 splice_insert, as defined in SCTE-35.
    splice_event_id: i64,

    pub const json_field_names = .{
        .duration = "Duration",
        .splice_event_id = "SpliceEventId",
    };
};
