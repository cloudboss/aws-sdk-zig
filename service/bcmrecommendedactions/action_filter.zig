const FilterName = @import("filter_name.zig").FilterName;
const MatchOption = @import("match_option.zig").MatchOption;

/// Describes a filter that returns a more specific list of recommended actions.
pub const ActionFilter = struct {
    /// The category to filter on. Valid values are `FEATURE` for feature type,
    /// `SEVERITY` for severity level, and `TYPE` for recommendation type.
    key: FilterName,

    /// Specifies how to apply the filter. Use `EQUALS` to include matching results
    /// or `NOT_EQUALS` to exclude matching results.
    match_option: MatchOption,

    /// One or more values to match against the specified key.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .match_option = "matchOption",
        .values = "values",
    };
};
