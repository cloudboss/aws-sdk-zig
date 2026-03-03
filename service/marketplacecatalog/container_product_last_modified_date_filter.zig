const ContainerProductLastModifiedDateFilterDateRange = @import("container_product_last_modified_date_filter_date_range.zig").ContainerProductLastModifiedDateFilterDateRange;

/// Object that allows filtering based on the last modified date of container
/// products.
pub const ContainerProductLastModifiedDateFilter = struct {
    /// Dates between which the container product was last modified.
    date_range: ?ContainerProductLastModifiedDateFilterDateRange = null,

    pub const json_field_names = .{
        .date_range = "DateRange",
    };
};
