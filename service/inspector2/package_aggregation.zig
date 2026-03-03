const StringFilter = @import("string_filter.zig").StringFilter;
const PackageSortBy = @import("package_sort_by.zig").PackageSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on operating system package
/// type.
pub const PackageAggregation = struct {
    /// The names of packages to aggregate findings on.
    package_names: ?[]const StringFilter = null,

    /// The value to sort results by.
    sort_by: ?PackageSortBy = null,

    /// The order to sort results by.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .package_names = "packageNames",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
