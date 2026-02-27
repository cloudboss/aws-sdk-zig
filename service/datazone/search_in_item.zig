/// The details of the search.
pub const SearchInItem = struct {
    /// The search attribute.
    attribute: []const u8,

    pub const json_field_names = .{
        .attribute = "attribute",
    };
};
