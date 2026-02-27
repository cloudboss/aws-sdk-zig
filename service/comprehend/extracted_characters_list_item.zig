/// Array of the number of characters extracted from each page.
pub const ExtractedCharactersListItem = struct {
    /// Number of characters extracted from each page.
    count: ?i32,

    /// Page number.
    page: ?i32,

    pub const json_field_names = .{
        .count = "Count",
        .page = "Page",
    };
};
