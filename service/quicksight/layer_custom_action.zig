const LayerCustomActionOperation = @import("layer_custom_action_operation.zig").LayerCustomActionOperation;
const WidgetStatus = @import("widget_status.zig").WidgetStatus;
const LayerCustomActionTrigger = @import("layer_custom_action_trigger.zig").LayerCustomActionTrigger;

/// A layer custom action.
pub const LayerCustomAction = struct {
    /// A list of `LayerCustomActionOperations`.
    ///
    /// This is a union type structure. For this structure to be valid, only one of
    /// the attributes can be defined.
    action_operations: []const LayerCustomActionOperation,

    /// The ID of the custom action.
    custom_action_id: []const u8,

    /// The name of the custom action.
    name: []const u8,

    /// The status of the `LayerCustomAction`.
    status: ?WidgetStatus = null,

    /// The trigger of the `LayerCustomAction`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `DATA_POINT_CLICK`: Initiates a custom action by a left pointer click on a
    ///   data point.
    ///
    /// * `DATA_POINT_MENU`: Initiates a custom action by right pointer click from
    ///   the menu.
    trigger: LayerCustomActionTrigger,

    pub const json_field_names = .{
        .action_operations = "ActionOperations",
        .custom_action_id = "CustomActionId",
        .name = "Name",
        .status = "Status",
        .trigger = "Trigger",
    };
};
