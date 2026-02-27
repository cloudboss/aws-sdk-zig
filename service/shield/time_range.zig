/// The time range.
pub const TimeRange = struct {
    /// The start time, in Unix time in seconds.
    from_inclusive: ?i64,

    /// The end time, in Unix time in seconds.
    to_exclusive: ?i64,

    pub const json_field_names = .{
        .from_inclusive = "FromInclusive",
        .to_exclusive = "ToExclusive",
    };
};
