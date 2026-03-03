const DataProductEntityIdFilter = @import("data_product_entity_id_filter.zig").DataProductEntityIdFilter;
const DataProductLastModifiedDateFilter = @import("data_product_last_modified_date_filter.zig").DataProductLastModifiedDateFilter;
const DataProductTitleFilter = @import("data_product_title_filter.zig").DataProductTitleFilter;
const DataProductVisibilityFilter = @import("data_product_visibility_filter.zig").DataProductVisibilityFilter;

/// Object containing all the filter fields for data products. Client can add
/// only one wildcard filter and a maximum of 8 filters in a single
/// `ListEntities` request.
pub const DataProductFilters = struct {
    /// Unique identifier for the data product.
    entity_id: ?DataProductEntityIdFilter = null,

    /// The last date on which the data product was modified.
    last_modified_date: ?DataProductLastModifiedDateFilter = null,

    /// The title of the data product.
    product_title: ?DataProductTitleFilter = null,

    /// The visibility of the data product.
    visibility: ?DataProductVisibilityFilter = null,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
