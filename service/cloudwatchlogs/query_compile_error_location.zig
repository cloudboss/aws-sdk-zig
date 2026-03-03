/// Reserved.
pub const QueryCompileErrorLocation = struct {
    /// Reserved.
    end_char_offset: ?i32 = null,

    /// Reserved.
    start_char_offset: ?i32 = null,

    pub const json_field_names = .{
        .end_char_offset = "endCharOffset",
        .start_char_offset = "startCharOffset",
    };
};
