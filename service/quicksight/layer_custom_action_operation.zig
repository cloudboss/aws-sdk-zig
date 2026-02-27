const CustomActionFilterOperation = @import("custom_action_filter_operation.zig").CustomActionFilterOperation;
const CustomActionNavigationOperation = @import("custom_action_navigation_operation.zig").CustomActionNavigationOperation;
const CustomActionSetParametersOperation = @import("custom_action_set_parameters_operation.zig").CustomActionSetParametersOperation;
const CustomActionURLOperation = @import("custom_action_url_operation.zig").CustomActionURLOperation;

/// The operation that is defined by the custom action.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const LayerCustomActionOperation = struct {
    filter_operation: ?CustomActionFilterOperation,

    navigation_operation: ?CustomActionNavigationOperation,

    set_parameters_operation: ?CustomActionSetParametersOperation,

    url_operation: ?CustomActionURLOperation,

    pub const json_field_names = .{
        .filter_operation = "FilterOperation",
        .navigation_operation = "NavigationOperation",
        .set_parameters_operation = "SetParametersOperation",
        .url_operation = "URLOperation",
    };
};
