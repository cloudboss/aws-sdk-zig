/// The search criteria based on user-defined contact attribute key and values
/// to search on.
pub const SearchableContactAttributesCriteria = struct {
    /// The key containing a searchable user-defined contact attribute.
    key: []const u8,

    /// The list of values to search for within a user-defined contact attribute.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
