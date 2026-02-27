/// Used to streamline results of a search based on the property being filtered.
pub const Filter = struct {
    /// The property being filtered. For example, UserId.
    name: []const u8,

    /// The property values to filter on. For example, "user-123".
    values: []const []const u8,
};
