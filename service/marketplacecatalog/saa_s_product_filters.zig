const SaaSProductEntityIdFilter = @import("saa_s_product_entity_id_filter.zig").SaaSProductEntityIdFilter;
const SaaSProductLastModifiedDateFilter = @import("saa_s_product_last_modified_date_filter.zig").SaaSProductLastModifiedDateFilter;
const SaaSProductTitleFilter = @import("saa_s_product_title_filter.zig").SaaSProductTitleFilter;
const SaaSProductVisibilityFilter = @import("saa_s_product_visibility_filter.zig").SaaSProductVisibilityFilter;

/// Object containing all the filter fields for SaaS products. Client can add
/// only one wildcard filter and a maximum of 8 filters in a single
/// `ListEntities` request.
pub const SaaSProductFilters = struct {
    /// Unique identifier for the SaaS product.
    entity_id: ?SaaSProductEntityIdFilter = null,

    /// The last date on which the SaaS product was modified.
    last_modified_date: ?SaaSProductLastModifiedDateFilter = null,

    /// The title of the SaaS product.
    product_title: ?SaaSProductTitleFilter = null,

    /// The visibility of the SaaS product.
    visibility: ?SaaSProductVisibilityFilter = null,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
