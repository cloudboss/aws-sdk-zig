const ImageCustomActionOperation = @import("image_custom_action_operation.zig").ImageCustomActionOperation;
const WidgetStatus = @import("widget_status.zig").WidgetStatus;
const ImageCustomActionTrigger = @import("image_custom_action_trigger.zig").ImageCustomActionTrigger;

/// A custom action defined on an image.
pub const ImageCustomAction = struct {
    /// A list of `ImageCustomActionOperations`.
    ///
    /// This is a union type structure. For this structure to be valid, only one of
    /// the attributes can be defined.
    action_operations: []const ImageCustomActionOperation,

    /// The ID of the custom action.
    custom_action_id: []const u8,

    /// The name of the custom action.
    name: []const u8,

    /// The status of the custom action.
    status: ?WidgetStatus,

    /// The trigger of the `VisualCustomAction`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `CLICK`: Initiates a custom action by a left pointer click on a data
    ///   point.
    ///
    /// * `MENU`: Initiates a custom action by right pointer click from the menu.
    trigger: ImageCustomActionTrigger,

    pub const json_field_names = .{
        .action_operations = "ActionOperations",
        .custom_action_id = "CustomActionId",
        .name = "Name",
        .status = "Status",
        .trigger = "Trigger",
    };
};
