const StringFilter = @import("string_filter.zig").StringFilter;
const MapFilter = @import("map_filter.zig").MapFilter;
const ServerlessFunctionSortBy = @import("serverless_function_sort_by.zig").ServerlessFunctionSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// An aggregation of information about serverless functions.
pub const ServerlessFunctionAggregation = struct {
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

    /// The function names to aggregate findings for.
    function_names: ?[]const StringFilter = null,

    /// The function tags to aggregate findings for.
    function_tags: ?[]const MapFilter = null,

    /// The resource IDs to aggregate findings for.
    resource_ids: ?[]const StringFilter = null,

    /// The runtimes to aggregate findings for.
    runtimes: ?[]const StringFilter = null,

    /// The value to sort results by. Specify a field name from the aggregation
    /// response, such as `CRITICAL`, `HIGH`, or `ALL`.
    sort_by: ?ServerlessFunctionSortBy = null,

    /// The order to sort results by. Valid values are `ASC` and `DESC`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .cloud_account_ids = "cloudAccountIds",
        .cloud_org_ids = "cloudOrgIds",
        .cloud_partitions = "cloudPartitions",
        .cloud_providers = "cloudProviders",
        .cloud_regions = "cloudRegions",
        .function_names = "functionNames",
        .function_tags = "functionTags",
        .resource_ids = "resourceIds",
        .runtimes = "runtimes",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
