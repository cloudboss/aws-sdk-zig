/// Settings for a SCTE-35 return_to_network message.
pub const Scte35ReturnToNetworkScheduleActionSettings = struct {
    /// The splice_event_id for the SCTE-35 splice_insert, as defined in SCTE-35.
    splice_event_id: i64,

    pub const json_field_names = .{
        .splice_event_id = "SpliceEventId",
    };
};
