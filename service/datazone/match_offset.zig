/// The offset of a matched term.
pub const MatchOffset = struct {
    /// The 0-indexed number indicating the end position (exclusive) of a matched
    /// term.
    end_offset: ?i32 = null,

    /// The 0-indexed number indicating the start position (inclusive) of a matched
    /// term.
    start_offset: ?i32 = null,

    pub const json_field_names = .{
        .end_offset = "endOffset",
        .start_offset = "startOffset",
    };
};
