const aws = @import("aws");

const FulfillmentState = @import("fulfillment_state.zig").FulfillmentState;
const MessageFormatType = @import("message_format_type.zig").MessageFormatType;
const DialogActionType = @import("dialog_action_type.zig").DialogActionType;

/// Describes the next action that the bot should take in its interaction
/// with the user and provides information about the context in which the
/// action takes place. Use the `DialogAction` data type to set the
/// interaction to a specific state, or to return the interaction to a
/// previous state.
pub const DialogAction = struct {
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

    /// The message that should be shown to the user. If you don't specify a
    /// message, Amazon Lex will use the message configured for the intent.
    message: ?[]const u8 = null,

    /// * `PlainText` - The message contains plain UTF-8
    /// text.
    ///
    /// * `CustomPayload` - The message is a custom format for
    /// the client.
    ///
    /// * `SSML` - The message contains text formatted for voice
    /// output.
    ///
    /// * `Composite` - The message contains an escaped JSON
    /// object containing one or more messages. For more information, see
    /// [Message
    /// Groups](https://docs.aws.amazon.com/lex/latest/dg/howitworks-manage-prompts.html).
    message_format: ?MessageFormatType = null,

    /// Map of the slots that have been gathered and their values.
    slots: ?[]const aws.map.StringMapEntry = null,

    /// The name of the slot that should be elicited from the user.
    slot_to_elicit: ?[]const u8 = null,

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
    /// * `Delegate` - The next action is determined by
    /// Amazon Lex.
    ///
    /// * `ElicitIntent` - The next action is to determine the
    /// intent that the user wants to fulfill.
    ///
    /// * `ElicitSlot` - The next action is to elicit a slot
    /// value from the user.
    @"type": DialogActionType,

    pub const json_field_names = .{
        .fulfillment_state = "fulfillmentState",
        .intent_name = "intentName",
        .message = "message",
        .message_format = "messageFormat",
        .slots = "slots",
        .slot_to_elicit = "slotToElicit",
        .@"type" = "type",
    };
};
