const Address = @import("address.zig").Address;
const AutocompleteHighlights = @import("autocomplete_highlights.zig").AutocompleteHighlights;
const PlaceType = @import("place_type.zig").PlaceType;

/// A result matching the input query text.
pub const AutocompleteResultItem = struct {
    /// The address associated with this result.
    address: ?Address,

    /// The distance in meters between the center of the search area and this
    /// result. Useful to evaluate how far away from the original bias position the
    /// result is.
    distance: i64 = 0,

    /// Indicates the starting and ending index of the place in the text query that
    /// match the found title.
    highlights: ?AutocompleteHighlights,

    /// A list of [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag)
    /// compliant language codes for the results to be rendered in. If there is no
    /// data for the result in the requested language, data will be returned in the
    /// default language for the entry.
    language: ?[]const u8,

    /// The PlaceId of the place associated with this result. This can be used to
    /// look up additional details about the result via GetPlace.
    place_id: []const u8,

    /// PlaceType describes the type of result entry returned.
    place_type: PlaceType,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    political_view: ?[]const u8,

    /// A formatted string for display when presenting this result to an end user.
    title: []const u8,

    pub const json_field_names = .{
        .address = "Address",
        .distance = "Distance",
        .highlights = "Highlights",
        .language = "Language",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .political_view = "PoliticalView",
        .title = "Title",
    };
};
