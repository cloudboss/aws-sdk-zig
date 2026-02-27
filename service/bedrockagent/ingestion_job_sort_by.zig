const IngestionJobSortByAttribute = @import("ingestion_job_sort_by_attribute.zig").IngestionJobSortByAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The parameters of sorting the data.
pub const IngestionJobSortBy = struct {
    /// The name of field or attribute to apply sorting of data.
    attribute: IngestionJobSortByAttribute,

    /// The order for sorting the data.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
