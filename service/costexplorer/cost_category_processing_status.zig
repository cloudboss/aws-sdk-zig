const CostCategoryStatusComponent = @import("cost_category_status_component.zig").CostCategoryStatusComponent;
const CostCategoryStatus = @import("cost_category_status.zig").CostCategoryStatus;

/// The list of processing statuses for Cost Management products for a specific
/// cost
/// category.
pub const CostCategoryProcessingStatus = struct {
    /// The Cost Management product name of the applied status.
    component: ?CostCategoryStatusComponent = null,

    /// The process status for a specific cost category.
    status: ?CostCategoryStatus = null,

    pub const json_field_names = .{
        .component = "Component",
        .status = "Status",
    };
};
