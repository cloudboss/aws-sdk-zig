const CallInstructionsMessageType = @import("call_instructions_message_type.zig").CallInstructionsMessageType;
const PlainTextMessageType = @import("plain_text_message_type.zig").PlainTextMessageType;
const SSMLMessageType = @import("ssml_message_type.zig").SSMLMessageType;

/// An object that contains a voice message and information about the recipient
/// that you want to send it to.
pub const VoiceMessageContent = struct {
    call_instructions_message: ?CallInstructionsMessageType,

    plain_text_message: ?PlainTextMessageType,

    ssml_message: ?SSMLMessageType,

    pub const json_field_names = .{
        .call_instructions_message = "CallInstructionsMessage",
        .plain_text_message = "PlainTextMessage",
        .ssml_message = "SSMLMessage",
    };
};
