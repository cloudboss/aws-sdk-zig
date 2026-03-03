const Highlight = @import("highlight.zig").Highlight;

/// Describes how the parts of the textQuery matched the input query by
/// returning the sections of the response which matched to textQuery terms.
pub const SuggestAddressHighlights = struct {
    /// Indicates the starting and ending indexes of the places in the result which
    /// were identified to match the textQuery. This result is useful for providing
    /// emphasis to results where the user query directly matched to make selecting
    /// the correct result from a list easier for an end user.
    label: ?[]const Highlight = null,

    pub const json_field_names = .{
        .label = "Label",
    };
};
