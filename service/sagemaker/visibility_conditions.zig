/// The list of key-value pairs used to filter your search results. If a search
/// result contains a key from your list, it is included in the final search
/// response if the value associated with the key in the result matches the
/// value you specified. If the value doesn't match, the result is excluded from
/// the search response. Any resources that don't have a key from the list that
/// you've provided will also be included in the search response.
pub const VisibilityConditions = struct {
    /// The key that specifies the tag that you're using to filter the search
    /// results. It must be in the following format: `Tags.<key>`.
    key: ?[]const u8,

    /// The value for the tag that you're using to filter the search results.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
