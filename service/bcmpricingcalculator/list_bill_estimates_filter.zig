const MatchOption = @import("match_option.zig").MatchOption;
const ListBillEstimatesFilterName = @import("list_bill_estimates_filter_name.zig").ListBillEstimatesFilterName;

/// Represents a filter for listing bill estimates.
pub const ListBillEstimatesFilter = struct {
    /// The match option for the filter (e.g., equals, contains).
    match_option: ?MatchOption = null,

    /// The name of the filter attribute.
    name: ListBillEstimatesFilterName,

    /// The values to filter by.
    values: []const []const u8,

    pub const json_field_names = .{
        .match_option = "matchOption",
        .name = "name",
        .values = "values",
    };
};
