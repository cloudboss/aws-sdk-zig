const ContainerProductEntityIdFilter = @import("container_product_entity_id_filter.zig").ContainerProductEntityIdFilter;
const ContainerProductLastModifiedDateFilter = @import("container_product_last_modified_date_filter.zig").ContainerProductLastModifiedDateFilter;
const ContainerProductTitleFilter = @import("container_product_title_filter.zig").ContainerProductTitleFilter;
const ContainerProductVisibilityFilter = @import("container_product_visibility_filter.zig").ContainerProductVisibilityFilter;

/// Object containing all the filter fields for container products. Client can
/// add only one wildcard filter and a maximum of 8 filters in a single
/// `ListEntities` request.
pub const ContainerProductFilters = struct {
    /// Unique identifier for the container product.
    entity_id: ?ContainerProductEntityIdFilter,

    /// The last date on which the container product was modified.
    last_modified_date: ?ContainerProductLastModifiedDateFilter,

    /// The title of the container product.
    product_title: ?ContainerProductTitleFilter,

    /// The visibility of the container product.
    visibility: ?ContainerProductVisibilityFilter,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
