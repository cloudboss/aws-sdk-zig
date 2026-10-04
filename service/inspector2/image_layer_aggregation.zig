const StringFilter = @import("string_filter.zig").StringFilter;
const ImageLayerSortBy = @import("image_layer_sort_by.zig").ImageLayerSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on container image layers.
pub const ImageLayerAggregation = struct {
    /// The cloud account IDs to aggregate findings for.
    cloud_account_ids: ?[]const StringFilter = null,

    /// The cloud organization IDs to aggregate findings for.
    cloud_org_ids: ?[]const StringFilter = null,

    /// The cloud partitions to aggregate findings for. Valid values:
    ///
    /// * `aws` – Amazon Web Services commercial Regions.
    ///
    /// * `aws-cn` – Amazon Web Services China Regions.
    ///
    /// * `aws-us-gov` – Amazon Web Services GovCloud (US) Regions.
    ///
    /// * `AzureCloud` – Azure commercial Regions.
    cloud_partitions: ?[]const StringFilter = null,

    /// The cloud providers to aggregate findings for. Valid values:
    ///
    /// * `AWS` – Findings from Amazon Web Services resources.
    ///
    /// * `AZURE` – Findings from Microsoft Azure resources.
    cloud_providers: ?[]const StringFilter = null,

    /// The cloud regions to aggregate findings for. The value format depends on the
    /// cloud provider:
    ///
    /// * An Amazon Web Services Region, such as `us-east-1`.
    ///
    /// * An Azure region, such as `eastus`.
    cloud_regions: ?[]const StringFilter = null,

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
        .cloud_account_ids = "cloudAccountIds",
        .cloud_org_ids = "cloudOrgIds",
        .cloud_partitions = "cloudPartitions",
        .cloud_providers = "cloudProviders",
        .cloud_regions = "cloudRegions",
        .layer_hashes = "layerHashes",
        .repositories = "repositories",
        .resource_ids = "resourceIds",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
