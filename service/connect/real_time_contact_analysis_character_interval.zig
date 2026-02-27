/// Begin and end offsets for a part of text.
pub const RealTimeContactAnalysisCharacterInterval = struct {
    /// The beginning of the character interval.
    begin_offset_char: i32 = 0,

    /// The end of the character interval.
    end_offset_char: i32 = 0,

    pub const json_field_names = .{
        .begin_offset_char = "BeginOffsetChar",
        .end_offset_char = "EndOffsetChar",
    };
};
