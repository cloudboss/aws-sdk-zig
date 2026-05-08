/// A time range filter for selecting sessions. Specifies the start and end
/// times to narrow down which sessions are included.
pub const SessionFilterConfig = struct {
    /// The end time of the time range. Only sessions with activity before this
    /// timestamp are included.
    end_time: ?i64 = null,

    /// The start time of the time range. Only sessions with activity at or after
    /// this timestamp are included.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
