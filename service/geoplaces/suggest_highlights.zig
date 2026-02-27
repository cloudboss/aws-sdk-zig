const SuggestAddressHighlights = @import("suggest_address_highlights.zig").SuggestAddressHighlights;
const Highlight = @import("highlight.zig").Highlight;

/// Describes how the parts of the textQuery matched the input query by
/// returning the sections of the response which matched to textQuery terms.
pub const SuggestHighlights = struct {
    /// The place's address.
    address: ?SuggestAddressHighlights,

    /// Indicates the starting and ending index of the title in the text query that
    /// match the found title.
    title: ?[]const Highlight,

    pub const json_field_names = .{
        .address = "Address",
        .title = "Title",
    };
};
