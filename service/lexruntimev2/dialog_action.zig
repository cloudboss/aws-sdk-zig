const StyleType = @import("style_type.zig").StyleType;
const ElicitSubSlot = @import("elicit_sub_slot.zig").ElicitSubSlot;
const DialogActionType = @import("dialog_action_type.zig").DialogActionType;

/// The next action that Amazon Lex V2 should take.
pub const DialogAction = struct {
    /// Configures the slot to use spell-by-letter or spell-by-word style.
    /// When you use a style on a slot, users can spell out their input to make
    /// it clear to your bot.
    ///
    /// * Spell by letter - "b" "o" "b"
    ///
    /// * Spell by word - "b as in boy" "o as in oscar" "b as in
    /// boy"
    ///
    /// For more information, see [
    /// Using spelling to enter slot values
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/spelling-styles.html).
    slot_elicitation_style: ?StyleType,

    /// The name of the slot that should be elicited from the user.
    slot_to_elicit: ?[]const u8,

    /// The name of the constituent sub slot of the composite slot
    /// specified in slotToElicit that should be elicited from the user.
    sub_slot_to_elicit: ?ElicitSubSlot,

    /// The next action that the bot should take in its interaction with the
    /// user. The following values are possible:
    ///
    /// * `Close` – Indicates that there will not be a
    /// response from the user. For example, the statement "Your order
    /// has been placed" does not require a response.
    ///
    /// * `ConfirmIntent` – The next action is asking the
    /// user if the intent is complete and ready to be fulfilled. This is
    /// a yes/no question such as "Place the order?"
    ///
    /// * `Delegate` – The next action is determined by
    /// Amazon Lex V2.
    ///
    /// * `ElicitIntent` – The next action is to elicit an
    /// intent from the user.
    ///
    /// * `ElicitSlot` – The next action is to elicit a slot
    /// value from the user.
    type: DialogActionType,

    pub const json_field_names = .{
        .slot_elicitation_style = "slotElicitationStyle",
        .slot_to_elicit = "slotToElicit",
        .sub_slot_to_elicit = "subSlotToElicit",
        .type = "type",
    };
};
