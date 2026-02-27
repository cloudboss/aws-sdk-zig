/// The search criteria based on searchable segment attribute key and values to
/// search on.
pub const SearchableSegmentAttributesCriteria = struct {
    /// The key containing a searchable segment attribute.
    key: []const u8,

    /// The list of values to search for within a searchable segment attribute.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
