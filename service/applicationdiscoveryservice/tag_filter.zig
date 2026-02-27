/// The tag filter. Valid names are: `tagKey`, `tagValue`,
/// `configurationId`.
pub const TagFilter = struct {
    /// A name of the tag filter.
    name: []const u8,

    /// Values for the tag filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
