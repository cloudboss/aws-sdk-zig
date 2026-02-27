/// Reserved.
pub const QueryCompileErrorLocation = struct {
    /// Reserved.
    end_char_offset: ?i32,

    /// Reserved.
    start_char_offset: ?i32,

    pub const json_field_names = .{
        .end_char_offset = "endCharOffset",
        .start_char_offset = "startCharOffset",
    };
};
