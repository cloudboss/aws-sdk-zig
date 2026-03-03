const StringFilter = @import("string_filter.zig").StringFilter;
const CodeRepositorySortBy = @import("code_repository_sort_by.zig").CodeRepositorySortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on code repositories.
pub const CodeRepositoryAggregation = struct {
    /// The project names to include in the aggregation results.
    project_names: ?[]const StringFilter = null,

    /// The repository provider types to include in the aggregation results.
    provider_types: ?[]const StringFilter = null,

    /// The resource IDs to include in the aggregation results.
    resource_ids: ?[]const StringFilter = null,

    /// The value to sort results by in the code repository aggregation.
    sort_by: ?CodeRepositorySortBy = null,

    /// The order to sort results by (ascending or descending) in the code
    /// repository
    /// aggregation.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .project_names = "projectNames",
        .provider_types = "providerTypes",
        .resource_ids = "resourceIds",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
