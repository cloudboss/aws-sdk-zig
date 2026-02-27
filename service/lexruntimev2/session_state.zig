const aws = @import("aws");

const ActiveContext = @import("active_context.zig").ActiveContext;
const DialogAction = @import("dialog_action.zig").DialogAction;
const Intent = @import("intent.zig").Intent;
const RuntimeHints = @import("runtime_hints.zig").RuntimeHints;

/// The state of the user's session with Amazon Lex V2.
pub const SessionState = struct {
    /// One or more contexts that indicate to Amazon Lex V2 the context of a
    /// request. When a context is active, Amazon Lex V2 considers intents with the
    /// matching context as a trigger as the next intent in a session.
    active_contexts: ?[]const ActiveContext,

    /// The next step that Amazon Lex V2 should take in the conversation with a
    /// user.
    dialog_action: ?DialogAction,

    /// The active intent that Amazon Lex V2 is processing.
    intent: ?Intent,

    /// A unique identifier for a specific request.
    originating_request_id: ?[]const u8,

    /// Hints for phrases that a customer is likely to use for a slot. Amazon Lex V2
    /// uses the hints to help determine the correct value of a slot.
    runtime_hints: ?RuntimeHints,

    /// Map of key/value pairs representing session-specific context
    /// information. It contains application information passed between Amazon Lex
    /// V2
    /// and a client application.
    session_attributes: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .dialog_action = "dialogAction",
        .intent = "intent",
        .originating_request_id = "originatingRequestId",
        .runtime_hints = "runtimeHints",
        .session_attributes = "sessionAttributes",
    };
};
