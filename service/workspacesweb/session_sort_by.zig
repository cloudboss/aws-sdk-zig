pub const SessionSortBy = enum {
    start_time_ascending,
    start_time_descending,

    pub const json_field_names = .{
        .start_time_ascending = "START_TIME_ASCENDING",
        .start_time_descending = "START_TIME_DESCENDING",
    };
};
