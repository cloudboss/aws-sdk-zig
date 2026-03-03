const MatchOption = @import("match_option.zig").MatchOption;
const ListWorkloadEstimatesFilterName = @import("list_workload_estimates_filter_name.zig").ListWorkloadEstimatesFilterName;

/// Represents a filter for listing workload estimates.
pub const ListWorkloadEstimatesFilter = struct {
    /// The match option for the filter (e.g., equals, contains).
    match_option: ?MatchOption = null,

    /// The name of the filter attribute.
    name: ListWorkloadEstimatesFilterName,

    /// The values to filter by.
    values: []const []const u8,

    pub const json_field_names = .{
        .match_option = "matchOption",
        .name = "name",
        .values = "values",
    };
};
