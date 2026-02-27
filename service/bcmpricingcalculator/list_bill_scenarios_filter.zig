const MatchOption = @import("match_option.zig").MatchOption;
const ListBillScenariosFilterName = @import("list_bill_scenarios_filter_name.zig").ListBillScenariosFilterName;

/// Represents a filter for listing bill scenarios.
pub const ListBillScenariosFilter = struct {
    /// The match option for the filter (e.g., equals, contains).
    match_option: ?MatchOption,

    /// The name of the filter attribute.
    name: ListBillScenariosFilterName,

    /// The values to filter by.
    values: []const []const u8,

    pub const json_field_names = .{
        .match_option = "matchOption",
        .name = "name",
        .values = "values",
    };
};
