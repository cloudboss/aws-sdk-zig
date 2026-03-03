const StringFilter = @import("string_filter.zig").StringFilter;
const RepositorySortBy = @import("repository_sort_by.zig").RepositorySortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on repository.
pub const RepositoryAggregation = struct {
    /// The names of repositories to aggregate findings on.
    repositories: ?[]const StringFilter = null,

    /// The value to sort results by.
    sort_by: ?RepositorySortBy = null,

    /// The order to sort results by.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .repositories = "repositories",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
