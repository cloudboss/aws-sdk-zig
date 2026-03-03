/// The time range.
pub const TimeRange = struct {
    /// The start time, in Unix time in seconds.
    from_inclusive: ?i64 = null,

    /// The end time, in Unix time in seconds.
    to_exclusive: ?i64 = null,

    pub const json_field_names = .{
        .from_inclusive = "FromInclusive",
        .to_exclusive = "ToExclusive",
    };
};
