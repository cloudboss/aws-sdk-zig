/// Specifies a time range for filtering certificates.
pub const TimestampRange = struct {
    /// The end of the time range. This value is inclusive.
    end: ?i64 = null,

    /// The start of the time range. This value is inclusive.
    start: ?i64 = null,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
