/// Array of the number of characters extracted from each page.
pub const ExtractedCharactersListItem = struct {
    /// Number of characters extracted from each page.
    count: ?i32 = null,

    /// Page number.
    page: ?i32 = null,

    pub const json_field_names = .{
        .count = "Count",
        .page = "Page",
    };
};
