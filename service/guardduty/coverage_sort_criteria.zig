const CoverageSortKey = @import("coverage_sort_key.zig").CoverageSortKey;
const OrderBy = @import("order_by.zig").OrderBy;

/// Information about the sorting criteria used in the coverage statistics.
pub const CoverageSortCriteria = struct {
    /// Represents the field name used to sort the coverage details.
    ///
    /// Replace the enum value `CLUSTER_NAME` with `EKS_CLUSTER_NAME`.
    /// `CLUSTER_NAME` has been deprecated.
    attribute_name: ?CoverageSortKey,

    /// The order in which the sorted findings are to be displayed.
    order_by: ?OrderBy,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .order_by = "OrderBy",
    };
};
