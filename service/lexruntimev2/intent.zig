const aws = @import("aws");

const ConfirmationState = @import("confirmation_state.zig").ConfirmationState;
const Slot = @import("slot.zig").Slot;
const IntentState = @import("intent_state.zig").IntentState;

/// The current intent that Amazon Lex V2 is attempting to fulfill.
pub const Intent = struct {
    /// Indicates whether the intent has been `Confirmed`, `Denied`, or `None` if
    /// the confirmation stage has not yet been reached.
    confirmation_state: ?ConfirmationState = null,

    /// The name of the intent.
    name: []const u8,

    /// A map of all of the slots for the intent. The name of the slot maps
    /// to the value of the slot. If a slot has not been filled, the value is
    /// null.
    slots: ?[]const aws.map.MapEntry(Slot) = null,

    /// Indicates the fulfillment state for the intent. The meanings of each value
    /// are as follows:
    ///
    /// * `Failed` – The bot failed to fulfill the intent.
    ///
    /// * `Fulfilled` – The bot has completed fulfillment of the intent.
    ///
    /// * `FulfillmentInProgress` – The bot is in the middle of fulfilling the
    ///   intent.
    ///
    /// * `InProgress` – The bot is in the middle of eliciting the slot values that
    ///   are necessary to fulfill the intent.
    ///
    /// * `ReadyForFulfillment` – The bot has elicited all the slot values for the
    ///   intent and is ready to fulfill the intent.
    ///
    /// * `Waiting` – The bot is waiting for a response from the user (limited to
    ///   streaming conversations).
    state: ?IntentState = null,

    pub const json_field_names = .{
        .confirmation_state = "confirmationState",
        .name = "name",
        .slots = "slots",
        .state = "state",
    };
};
