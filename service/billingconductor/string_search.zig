const SearchOption = @import("search_option.zig").SearchOption;

/// A structure that defines string search parameters.
pub const StringSearch = struct {
    /// The search option to be applied when performing the string search.
    search_option: SearchOption,

    /// The value to search for within the specified string field.
    search_value: []const u8,

    pub const json_field_names = .{
        .search_option = "SearchOption",
        .search_value = "SearchValue",
    };
};
