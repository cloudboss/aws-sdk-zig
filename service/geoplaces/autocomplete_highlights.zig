const AutocompleteAddressHighlights = @import("autocomplete_address_highlights.zig").AutocompleteAddressHighlights;
const Highlight = @import("highlight.zig").Highlight;

/// Describes how the parts of the response element matched the input query by
/// returning the sections of the response which matched to input query terms.
pub const AutocompleteHighlights = struct {
    /// Describes how part of the result address match the input query.
    address: ?AutocompleteAddressHighlights,

    /// Indicates where the title field in the result matches the input query.
    title: ?[]const Highlight,

    pub const json_field_names = .{
        .address = "Address",
        .title = "Title",
    };
};
