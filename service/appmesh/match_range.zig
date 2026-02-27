/// An object that represents the range of values to match on. The first
/// character of the range is included in the range, though the last character
/// is not. For example, if the range specified were 1-100, only values 1-99
/// would be matched.
pub const MatchRange = struct {
    /// The end of the range.
    end: i64,

    /// The start of the range.
    start: i64,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
