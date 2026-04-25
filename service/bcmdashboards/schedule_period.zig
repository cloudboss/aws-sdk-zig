/// Defines the active time period for execution of the scheduled report.
pub const SchedulePeriod = struct {
    /// The end time of the schedule period. If not specified, defaults to 3 years
    /// from the time of the create or update request. The maximum allowed value is
    /// 3 years from the current time. Setting an end time beyond this limit returns
    /// a `ValidationException`.
    end_time: ?i64 = null,

    /// The start time of the schedule period. If not specified, defaults to the
    /// time of the create or update request. The start time cannot be more than 5
    /// minutes before the time of the request.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
