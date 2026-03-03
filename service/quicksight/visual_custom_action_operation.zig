const CustomActionFilterOperation = @import("custom_action_filter_operation.zig").CustomActionFilterOperation;
const CustomActionNavigationOperation = @import("custom_action_navigation_operation.zig").CustomActionNavigationOperation;
const CustomActionSetParametersOperation = @import("custom_action_set_parameters_operation.zig").CustomActionSetParametersOperation;
const CustomActionURLOperation = @import("custom_action_url_operation.zig").CustomActionURLOperation;

/// The operation that is defined by the custom action.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const VisualCustomActionOperation = struct {
    /// The filter operation that filters data included in a visual or in an entire
    /// sheet.
    filter_operation: ?CustomActionFilterOperation = null,

    /// The navigation operation that navigates between different sheets in the same
    /// analysis.
    navigation_operation: ?CustomActionNavigationOperation = null,

    /// The set parameter operation that sets parameters in custom action.
    set_parameters_operation: ?CustomActionSetParametersOperation = null,

    /// The URL operation that opens a link to another webpage.
    url_operation: ?CustomActionURLOperation = null,

    pub const json_field_names = .{
        .filter_operation = "FilterOperation",
        .navigation_operation = "NavigationOperation",
        .set_parameters_operation = "SetParametersOperation",
        .url_operation = "URLOperation",
    };
};
