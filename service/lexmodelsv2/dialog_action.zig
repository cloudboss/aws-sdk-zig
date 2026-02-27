const DialogActionType = @import("dialog_action_type.zig").DialogActionType;

/// Defines the action that the bot executes at runtime when the
/// conversation reaches this step.
pub const DialogAction = struct {
    /// If the dialog action is `ElicitSlot`, defines the slot to
    /// elicit from the user.
    slot_to_elicit: ?[]const u8,

    /// When true the next message for the intent is not used.
    suppress_next_message: ?bool,

    /// The action that the bot should execute.
    type: DialogActionType,

    pub const json_field_names = .{
        .slot_to_elicit = "slotToElicit",
        .suppress_next_message = "suppressNextMessage",
        .type = "type",
    };
};
