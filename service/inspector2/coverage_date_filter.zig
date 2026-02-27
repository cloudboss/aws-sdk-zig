/// Contains details of a coverage date filter.
pub const CoverageDateFilter = struct {
    /// A timestamp representing the end of the time period to filter results by.
    end_inclusive: ?i64,

    /// A timestamp representing the start of the time period to filter results by.
    start_inclusive: ?i64,

    pub const json_field_names = .{
        .end_inclusive = "endInclusive",
        .start_inclusive = "startInclusive",
    };
};
