const aws = @import("aws");

const ConfirmationStatus = @import("confirmation_status.zig").ConfirmationStatus;
const DialogActionType = @import("dialog_action_type.zig").DialogActionType;
const FulfillmentState = @import("fulfillment_state.zig").FulfillmentState;

/// Provides information about the state of an intent. You can use this
/// information to get the current state of an intent so that you can process
/// the intent, or so that you can return the intent to its previous
/// state.
pub const IntentSummary = struct {
    /// A user-defined label that identifies a particular intent. You can use
    /// this label to return to a previous intent.
    ///
    /// Use the `checkpointLabelFilter` parameter of the
    /// `GetSessionRequest` operation to filter the intents returned
    /// by the operation to those with only the specified label.
    checkpoint_label: ?[]const u8 = null,

    /// The status of the intent after the user responds to the confirmation
    /// prompt. If the user confirms the intent, Amazon Lex sets this field to
    /// `Confirmed`. If the user denies the intent, Amazon Lex sets this
    /// value to `Denied`. The possible values are:
    ///
    /// * `Confirmed` - The user has responded "Yes" to the
    /// confirmation prompt, confirming that the intent is complete and that
    /// it is ready to be fulfilled.
    ///
    /// * `Denied` - The user has responded "No" to the
    /// confirmation prompt.
    ///
    /// * `None` - The user has never been prompted for
    /// confirmation; or, the user was prompted but did not confirm or deny
    /// the prompt.
    confirmation_status: ?ConfirmationStatus = null,

    /// The next action that the bot should take in its interaction with the
    /// user. The possible values are:
    ///
    /// * `ConfirmIntent` - The next action is asking the user if
    /// the intent is complete and ready to be fulfilled. This is a yes/no
    /// question such as "Place the order?"
    ///
    /// * `Close` - Indicates that the there will not be a
    /// response from the user. For example, the statement "Your order has
    /// been placed" does not require a response.
    ///
    /// * `ElicitIntent` - The next action is to determine the
    /// intent that the user wants to fulfill.
    ///
    /// * `ElicitSlot` - The next action is to elicit a slot
    /// value from the user.
    dialog_action_type: DialogActionType,

    /// The fulfillment state of the intent. The possible values are:
    ///
    /// * `Failed` - The Lambda function associated with the
    /// intent failed to fulfill the intent.
    ///
    /// * `Fulfilled` - The intent has fulfilled by the Lambda
    /// function associated with the intent.
    ///
    /// * `ReadyForFulfillment` - All of the information
    /// necessary for the intent is present and the intent ready to be
    /// fulfilled by the client application.
    fulfillment_state: ?FulfillmentState = null,

    /// The name of the intent.
    intent_name: ?[]const u8 = null,

    /// Map of the slots that have been gathered and their values.
    slots: ?[]const aws.map.StringMapEntry = null,

    /// The next slot to elicit from the user. If there is not slot to elicit,
    /// the field is blank.
    slot_to_elicit: ?[]const u8 = null,

    pub const json_field_names = .{
        .checkpoint_label = "checkpointLabel",
        .confirmation_status = "confirmationStatus",
        .dialog_action_type = "dialogActionType",
        .fulfillment_state = "fulfillmentState",
        .intent_name = "intentName",
        .slots = "slots",
        .slot_to_elicit = "slotToElicit",
    };
};
