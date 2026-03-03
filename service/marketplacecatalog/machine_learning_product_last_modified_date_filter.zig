const MachineLearningProductLastModifiedDateFilterDateRange = @import("machine_learning_product_last_modified_date_filter_date_range.zig").MachineLearningProductLastModifiedDateFilterDateRange;

/// The filter for machine learning product last modified date.
pub const MachineLearningProductLastModifiedDateFilter = struct {
    /// A date range to filter by. The operation returns machine learning products
    /// with last modified dates that fall within this range.
    date_range: ?MachineLearningProductLastModifiedDateFilterDateRange = null,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
