/// The text highlights for a single query suggestion.
pub const SuggestionHighlight = struct {
    /// The zero-based location in the response string where the highlight starts.
    begin_offset: ?i32,

    /// The zero-based location in the response string where the highlight ends.
    end_offset: ?i32,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
    };
};
