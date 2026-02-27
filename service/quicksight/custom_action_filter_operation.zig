const FilterOperationSelectedFieldsConfiguration = @import("filter_operation_selected_fields_configuration.zig").FilterOperationSelectedFieldsConfiguration;
const FilterOperationTargetVisualsConfiguration = @import("filter_operation_target_visuals_configuration.zig").FilterOperationTargetVisualsConfiguration;

/// The filter operation that filters data included in a visual or in an entire
/// sheet.
pub const CustomActionFilterOperation = struct {
    /// The configuration that chooses the fields to be filtered.
    selected_fields_configuration: FilterOperationSelectedFieldsConfiguration,

    /// The configuration that chooses the target visuals to be filtered.
    target_visuals_configuration: FilterOperationTargetVisualsConfiguration,

    pub const json_field_names = .{
        .selected_fields_configuration = "SelectedFieldsConfiguration",
        .target_visuals_configuration = "TargetVisualsConfiguration",
    };
};
