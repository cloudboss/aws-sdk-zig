const ActionReviewEvent = @import("action_review_event.zig").ActionReviewEvent;
const AuthChallengeRequestEvent = @import("auth_challenge_request_event.zig").AuthChallengeRequestEvent;
const FailedAttachmentEvent = @import("failed_attachment_event.zig").FailedAttachmentEvent;
const MetadataEvent = @import("metadata_event.zig").MetadataEvent;
const TextOutputEvent = @import("text_output_event.zig").TextOutputEvent;

/// The streaming output for the `Chat` API.
pub const ChatOutputStream = union(enum) {
    /// A request from Amazon Q Business to the end user for information Amazon Q
    /// Business needs to successfully complete a requested plugin action.
    action_review_event: ?ActionReviewEvent,
    /// An authentication verification event activated by an end user request to use
    /// a custom plugin.
    auth_challenge_request_event: ?AuthChallengeRequestEvent,
    /// A failed file upload event during a web experience chat.
    failed_attachment_event: ?FailedAttachmentEvent,
    /// A metadata event for a AI-generated text output message in a Amazon Q
    /// Business conversation.
    metadata_event: ?MetadataEvent,
    /// Information about the payload of the `ChatOutputStream` event containing the
    /// AI-generated message output.
    text_event: ?TextOutputEvent,

    pub const json_field_names = .{
        .action_review_event = "actionReviewEvent",
        .auth_challenge_request_event = "authChallengeRequestEvent",
        .failed_attachment_event = "failedAttachmentEvent",
        .metadata_event = "metadataEvent",
        .text_event = "textEvent",
    };
};
