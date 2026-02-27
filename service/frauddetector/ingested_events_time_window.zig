/// The start and stop time of the ingested events.
pub const IngestedEventsTimeWindow = struct {
    /// Timestamp of the final ingested event.
    end_time: []const u8,

    /// Timestamp of the first ingensted event.
    start_time: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
