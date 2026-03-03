/// A corrected misspelled word in a query.
pub const Correction = struct {
    /// The zero-based location in the response string or text where
    /// the corrected word starts.
    begin_offset: ?i32 = null,

    /// The string or text of a corrected misspelled word in a query.
    corrected_term: ?[]const u8 = null,

    /// The zero-based location in the response string or text where
    /// the corrected word ends.
    end_offset: ?i32 = null,

    /// The string or text of a misspelled word in a query.
    term: ?[]const u8 = null,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .corrected_term = "CorrectedTerm",
        .end_offset = "EndOffset",
        .term = "Term",
    };
};
