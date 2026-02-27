/// Clip range configuration for the VOD source associated with the program.
pub const ClipRange = struct {
    /// The end offset of the clip range, in milliseconds, starting from the
    /// beginning of the VOD source associated with the program.
    end_offset_millis: i64 = 0,

    /// The start offset of the clip range, in milliseconds. This offset truncates
    /// the start at the number of milliseconds into the duration of the VOD source.
    start_offset_millis: ?i64,

    pub const json_field_names = .{
        .end_offset_millis = "EndOffsetMillis",
        .start_offset_millis = "StartOffsetMillis",
    };
};
