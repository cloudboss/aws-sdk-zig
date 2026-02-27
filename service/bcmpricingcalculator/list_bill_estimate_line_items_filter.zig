const MatchOption = @import("match_option.zig").MatchOption;
const ListBillEstimateLineItemsFilterName = @import("list_bill_estimate_line_items_filter_name.zig").ListBillEstimateLineItemsFilterName;

/// Represents a filter for listing bill estimate line items.
pub const ListBillEstimateLineItemsFilter = struct {
    /// The match option for the filter (e.g., equals, contains).
    match_option: ?MatchOption,

    /// The name of the filter attribute.
    name: ListBillEstimateLineItemsFilterName,

    /// The values to filter by.
    values: []const []const u8,

    pub const json_field_names = .{
        .match_option = "matchOption",
        .name = "name",
        .values = "values",
    };
};
