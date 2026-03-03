/// The filter criteria used for import tasks
pub const ImportFilter = struct {
    /// The end of the time range for events to import, expressed as the number of
    /// milliseconds after Jan 1, 1970 00:00:00 UTC.
    end_event_time: ?i64 = null,

    /// The start of the time range for events to import, expressed as the number of
    /// milliseconds after Jan 1, 1970 00:00:00 UTC.
    start_event_time: ?i64 = null,

    pub const json_field_names = .{
        .end_event_time = "endEventTime",
        .start_event_time = "startEventTime",
    };
};
