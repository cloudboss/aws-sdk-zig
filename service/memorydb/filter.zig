/// Used to streamline results of a search based on the property being filtered.
pub const Filter = struct {
    /// The property being filtered. For example, UserName.
    name: []const u8,

    /// The property values to filter on. For example, "user-123".
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
