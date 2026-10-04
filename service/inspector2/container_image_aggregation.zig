const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;
const DateFilter = @import("date_filter.zig").DateFilter;
const ContainerImageSortBy = @import("container_image_sort_by.zig").ContainerImageSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// An aggregation of information about container images.
pub const ContainerImageAggregation = struct {
    /// The image architectures to aggregate findings for.
    architectures: ?[]const StringFilter = null,

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

    /// The image digests to aggregate findings for.
    image_digests: ?[]const StringFilter = null,

    /// The image tags to aggregate findings for.
    image_tags: ?[]const StringFilter = null,

    /// The in-use counts to aggregate findings for.
    in_use_count: ?[]const NumberFilter = null,

    /// The last in-use timestamps to aggregate findings for.
    last_in_use_at: ?[]const DateFilter = null,

    /// The image registries to aggregate findings for.
    registries: ?[]const StringFilter = null,

    /// The image repositories to aggregate findings for.
    repositories: ?[]const StringFilter = null,

    /// The resource IDs to aggregate findings for.
    resource_ids: ?[]const StringFilter = null,

    /// The value to sort results by. Specify a field name from the aggregation
    /// response, such as `CRITICAL`, `HIGH`, or `ALL`.
    sort_by: ?ContainerImageSortBy = null,

    /// The order to sort results by. Valid values are `ASC` and `DESC`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .architectures = "architectures",
        .cloud_account_ids = "cloudAccountIds",
        .cloud_org_ids = "cloudOrgIds",
        .cloud_partitions = "cloudPartitions",
        .cloud_providers = "cloudProviders",
        .cloud_regions = "cloudRegions",
        .image_digests = "imageDigests",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .registries = "registries",
        .repositories = "repositories",
        .resource_ids = "resourceIds",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
