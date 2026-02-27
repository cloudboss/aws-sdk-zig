const DataProductLastModifiedDateFilterDateRange = @import("data_product_last_modified_date_filter_date_range.zig").DataProductLastModifiedDateFilterDateRange;

/// Object that allows filtering based on the last modified date of data
/// products.
pub const DataProductLastModifiedDateFilter = struct {
    /// Dates between which the data product was last modified.
    date_range: ?DataProductLastModifiedDateFilterDateRange,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
