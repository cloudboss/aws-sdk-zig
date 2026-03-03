const ExtractedCharactersListItem = @import("extracted_characters_list_item.zig").ExtractedCharactersListItem;

/// Information about the document, discovered during text extraction.
pub const DocumentMetadata = struct {
    /// List of pages in the document, with the number of characters extracted from
    /// each page.
    extracted_characters: ?[]const ExtractedCharactersListItem = null,

    /// Number of pages in the document.
    pages: ?i32 = null,

    pub const json_field_names = .{
        .extracted_characters = "ExtractedCharacters",
        .pages = "Pages",
    };
};
