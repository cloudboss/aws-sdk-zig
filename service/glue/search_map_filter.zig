const SearchMapFilterValue = @import("search_map_filter_value.zig").SearchMapFilterValue;

/// A filter on a map attribute's key-value pair.
pub const SearchMapFilter = struct {
    /// The map attribute name to filter on.
    attribute: []const u8,

    /// The key within the map attribute to filter on.
    key: []const u8,

    /// The value to compare against.
    value: SearchMapFilterValue,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .key = "Key",
        .value = "Value",
    };
};
