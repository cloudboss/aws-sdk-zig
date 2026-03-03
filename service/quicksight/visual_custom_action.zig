const VisualCustomActionOperation = @import("visual_custom_action_operation.zig").VisualCustomActionOperation;
const WidgetStatus = @import("widget_status.zig").WidgetStatus;
const VisualCustomActionTrigger = @import("visual_custom_action_trigger.zig").VisualCustomActionTrigger;

/// A custom action defined on a visual.
pub const VisualCustomAction = struct {
    /// A list of `VisualCustomActionOperations`.
    ///
    /// This is a union type structure. For this structure to be valid, only one of
    /// the attributes can be defined.
    action_operations: []const VisualCustomActionOperation,

    /// The ID of the `VisualCustomAction`.
    custom_action_id: []const u8,

    /// The name of the `VisualCustomAction`.
    name: []const u8,

    /// The status of the `VisualCustomAction`.
    status: ?WidgetStatus = null,

    /// The trigger of the `VisualCustomAction`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `DATA_POINT_CLICK`: Initiates a custom action by a left pointer click on a
    ///   data point.
    ///
    /// * `DATA_POINT_MENU`: Initiates a custom action by right pointer click from
    ///   the menu.
    trigger: VisualCustomActionTrigger,

    pub const json_field_names = .{
        .action_operations = "ActionOperations",
        .custom_action_id = "CustomActionId",
        .name = "Name",
        .status = "Status",
        .trigger = "Trigger",
    };
};
