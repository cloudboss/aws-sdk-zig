/// Represents a filter used within an expression.
pub const ExpressionFilter = struct {
    /// The key or attribute to filter on.
    key: ?[]const u8,

    /// The match options for the filter (e.g., equals, contains).
    match_options: ?[]const []const u8,

    /// The values to match against.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .match_options = "matchOptions",
        .values = "values",
    };
};
