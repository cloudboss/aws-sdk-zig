const StringFilter = @import("string_filter.zig").StringFilter;
const ImageLayerSortBy = @import("image_layer_sort_by.zig").ImageLayerSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on container image layers.
pub const ImageLayerAggregation = struct {
    /// The hashes associated with the layers.
    layer_hashes: ?[]const StringFilter = null,

    /// The repository associated with the container image hosting the layers.
    repositories: ?[]const StringFilter = null,

    /// The ID of the container image layer.
    resource_ids: ?[]const StringFilter = null,

    /// The value to sort results by.
    sort_by: ?ImageLayerSortBy = null,

    /// The order to sort results by.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .layer_hashes = "layerHashes",
        .repositories = "repositories",
        .resource_ids = "resourceIds",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
