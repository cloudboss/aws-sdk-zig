/// Indicates the starting and ending index of the text query that match the
/// found title.
pub const Highlight = struct {
    /// End index of the highlight.
    end_index: ?i32,

    /// Start index of the highlight.
    start_index: ?i32,

    /// The highlight's value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .end_index = "EndIndex",
        .start_index = "StartIndex",
        .value = "Value",
    };
};
