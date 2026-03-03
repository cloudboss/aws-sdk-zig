const Dimension = @import("dimension.zig").Dimension;
const MatchOption = @import("match_option.zig").MatchOption;

/// Specifies the values and match options for dimension-based filtering in cost
/// and usage queries.
pub const DimensionValues = struct {
    /// The key of the dimension to filter on (for example, `SERVICE`, `USAGE_TYPE`,
    /// or `OPERATION`).
    key: Dimension,

    /// The match options for dimension values, such as `EQUALS`, `CONTAINS`,
    /// `STARTS_WITH`, or `ENDS_WITH`.
    match_options: ?[]const MatchOption = null,

    /// The values to match for the specified dimension key.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .match_options = "matchOptions",
        .values = "values",
    };
};
