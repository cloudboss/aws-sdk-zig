const ActionParameters = @import("action_parameters.zig").ActionParameters;

/// Describes the configuration of an event. You can bind an event and a
/// corresponding action
/// to a `Component` or a `ComponentChild`. A button click is an example of
/// an event.
pub const ComponentEvent = struct {
    /// The action to perform when a specific event is raised.
    action: ?[]const u8 = null,

    /// Binds an event to an action on a component. When you specify a
    /// `bindingEvent`,
    /// the event is called when the action is performed.
    binding_event: ?[]const u8 = null,

    /// Describes information about the action.
    parameters: ?ActionParameters = null,

    pub const json_field_names = .{
        .action = "action",
        .binding_event = "bindingEvent",
        .parameters = "parameters",
    };
};
