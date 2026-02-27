/// Contains the timestamp range (start time through end time) of a matched
/// category.
pub const TimestampRange = struct {
    /// The time, in milliseconds, from the beginning of the audio stream to the
    /// start of the category
    /// match.
    begin_offset_millis: ?i64,

    /// The time, in milliseconds, from the beginning of the audio stream to the end
    /// of the category
    /// match.
    end_offset_millis: ?i64,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
        .end_offset_millis = "EndOffsetMillis",
    };
};
