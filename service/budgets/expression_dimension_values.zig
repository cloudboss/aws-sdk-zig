const Dimension = @import("dimension.zig").Dimension;
const MatchOption = @import("match_option.zig").MatchOption;

/// Contains the specifications for the filters to use for your request.
pub const ExpressionDimensionValues = struct {
    /// The name of the dimension that you want to filter on.
    key: Dimension,

    /// The match options that you can use to filter your results. You can specify
    /// only one of these
    /// values in the array.
    match_options: ?[]const MatchOption,

    /// The metadata values you can specify to filter upon, so that the results all
    /// match at least
    /// one of the specified values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};
