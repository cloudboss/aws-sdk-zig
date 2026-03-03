const AmiProductEntityIdFilter = @import("ami_product_entity_id_filter.zig").AmiProductEntityIdFilter;
const AmiProductLastModifiedDateFilter = @import("ami_product_last_modified_date_filter.zig").AmiProductLastModifiedDateFilter;
const AmiProductTitleFilter = @import("ami_product_title_filter.zig").AmiProductTitleFilter;
const AmiProductVisibilityFilter = @import("ami_product_visibility_filter.zig").AmiProductVisibilityFilter;

/// Object containing all the filter fields for AMI products. Client can add
/// only one wildcard filter and a maximum of 8
/// filters in a single `ListEntities` request.
pub const AmiProductFilters = struct {
    /// Unique identifier for the AMI product.
    entity_id: ?AmiProductEntityIdFilter = null,

    /// The last date on which the AMI product was modified.
    last_modified_date: ?AmiProductLastModifiedDateFilter = null,

    /// The title of the AMI product.
    product_title: ?AmiProductTitleFilter = null,

    /// The visibility of the AMI product.
    visibility: ?AmiProductVisibilityFilter = null,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
