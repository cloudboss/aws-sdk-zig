const SearchOption = @import("search_option.zig").SearchOption;

/// A structure that defines how to search for string values. You can specify a
/// search option and the value to search for.
pub const StringSearch = struct {
    /// The type of search operation to perform on the string value. Determines how
    /// the search value is matched against the target field.
    search_option: SearchOption,

    /// The string value to use in the search operation. This value is compared
    /// against the target field using the specified search option.
    search_value: []const u8,

    pub const json_field_names = .{
        .search_option = "searchOption",
        .search_value = "searchValue",
    };
};
