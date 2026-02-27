const aws = @import("aws");

const DialogAction = @import("dialog_action.zig").DialogAction;
const IntentOverride = @import("intent_override.zig").IntentOverride;

/// The current state of the conversation with the user.
pub const DialogState = struct {
    dialog_action: ?DialogAction,

    intent: ?IntentOverride,

    /// Map of key/value pairs representing session-specific context
    /// information. It contains application information passed between Amazon Lex
    /// and a client application.
    session_attributes: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .dialog_action = "dialogAction",
        .intent = "intent",
        .session_attributes = "sessionAttributes",
    };
};
