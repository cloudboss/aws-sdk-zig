const CategoryFilterMatchOperator = @import("category_filter_match_operator.zig").CategoryFilterMatchOperator;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;
const CategoryFilterSelectAllOptions = @import("category_filter_select_all_options.zig").CategoryFilterSelectAllOptions;

/// A list of custom filter values.
pub const CustomFilterListConfiguration = struct {
    /// The list of category values for the filter.
    category_values: ?[]const []const u8,

    /// The match operator that is used to determine if a filter should be applied.
    match_operator: CategoryFilterMatchOperator,

    /// This option determines how null values should be treated when filtering
    /// data.
    ///
    /// * `ALL_VALUES`: Include null values in filtered results.
    ///
    /// * `NULLS_ONLY`: Only include null values in filtered results.
    ///
    /// * `NON_NULLS_ONLY`: Exclude null values from filtered results.
    null_option: FilterNullOption,

    /// Select all of the values. Null is not the assigned value of select all.
    ///
    /// * `FILTER_ALL_VALUES`
    select_all_options: ?CategoryFilterSelectAllOptions,

    pub const json_field_names = .{
        .category_values = "CategoryValues",
        .match_operator = "MatchOperator",
        .null_option = "NullOption",
        .select_all_options = "SelectAllOptions",
    };
};
