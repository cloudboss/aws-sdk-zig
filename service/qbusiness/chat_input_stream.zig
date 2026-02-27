const ActionExecutionEvent = @import("action_execution_event.zig").ActionExecutionEvent;
const AttachmentInputEvent = @import("attachment_input_event.zig").AttachmentInputEvent;
const AuthChallengeResponseEvent = @import("auth_challenge_response_event.zig").AuthChallengeResponseEvent;
const ConfigurationEvent = @import("configuration_event.zig").ConfigurationEvent;
const EndOfInputEvent = @import("end_of_input_event.zig").EndOfInputEvent;
const TextInputEvent = @import("text_input_event.zig").TextInputEvent;

/// The streaming input for the `Chat` API.
pub const ChatInputStream = union(enum) {
    /// A request from an end user to perform an Amazon Q Business plugin action.
    action_execution_event: ?ActionExecutionEvent,
    /// A request by an end user to upload a file during chat.
    attachment_event: ?AttachmentInputEvent,
    /// An authentication verification event response by a third party
    /// authentication server to Amazon Q Business.
    auth_challenge_response_event: ?AuthChallengeResponseEvent,
    /// A configuration event activated by an end user request to select a specific
    /// chat mode.
    configuration_event: ?ConfigurationEvent,
    /// The end of the streaming input for the `Chat` API.
    end_of_input_event: ?EndOfInputEvent,
    /// Information about the payload of the `ChatInputStream` event containing the
    /// end user message input.
    text_event: ?TextInputEvent,

    pub const json_field_names = .{
        .action_execution_event = "actionExecutionEvent",
        .attachment_event = "attachmentEvent",
        .auth_challenge_response_event = "authChallengeResponseEvent",
        .configuration_event = "configurationEvent",
        .end_of_input_event = "endOfInputEvent",
        .text_event = "textEvent",
    };
};
