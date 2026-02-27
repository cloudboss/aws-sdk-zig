const OtherCategories = @import("other_categories.zig").OtherCategories;

/// The limit configuration of the visual display for an axis.
pub const ItemsLimitConfiguration = struct {
    /// The limit on how many items of a field are showed in the chart. For
    /// example, the number of slices that are displayed in a pie chart.
    items_limit: ?i64,

    /// The `Show
    /// other` of an axis in the chart. Choose one of the following options:
    ///
    /// * `INCLUDE`
    ///
    /// * `EXCLUDE`
    other_categories: ?OtherCategories,

    pub const json_field_names = .{
        .items_limit = "ItemsLimit",
        .other_categories = "OtherCategories",
    };
};
