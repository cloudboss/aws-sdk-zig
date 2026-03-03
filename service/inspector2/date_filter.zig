/// Contains details on the time range used to filter findings.
pub const DateFilter = struct {
    /// A timestamp representing the end of the time period filtered on.
    end_inclusive: ?i64 = null,

    /// A timestamp representing the start of the time period filtered on.
    start_inclusive: ?i64 = null,

    pub const json_field_names = .{
        .end_inclusive = "endInclusive",
        .start_inclusive = "startInclusive",
    };
};
