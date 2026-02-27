/// Contains details on the time range used to filter data.
pub const DateFilter = struct {
    /// A timestamp representing the end date of the time period until when data is
    /// filtered, including the end date.
    end_inclusive: i64,

    /// A timestamp representing the start of the time period from when data is
    /// filtered, including the start date.
    start_inclusive: i64,

    pub const json_field_names = .{
        .end_inclusive = "EndInclusive",
        .start_inclusive = "StartInclusive",
    };
};
