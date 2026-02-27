const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const AudioResponseEvent = @import("audio_response_event.zig").AudioResponseEvent;
const BadGatewayException = @import("errors.zig").BadGatewayException;
const ConflictException = @import("errors.zig").ConflictException;
const DependencyFailedException = @import("errors.zig").DependencyFailedException;
const HeartbeatEvent = @import("heartbeat_event.zig").HeartbeatEvent;
const IntentResultEvent = @import("intent_result_event.zig").IntentResultEvent;
const InternalServerException = @import("errors.zig").InternalServerException;
const PlaybackInterruptionEvent = @import("playback_interruption_event.zig").PlaybackInterruptionEvent;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const TextResponseEvent = @import("text_response_event.zig").TextResponseEvent;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const TranscriptEvent = @import("transcript_event.zig").TranscriptEvent;
const ValidationException = @import("errors.zig").ValidationException;

/// Represents a stream of events between Amazon Lex V2 and your
/// application.
pub const StartConversationResponseEventStream = union(enum) {
    /// Exception thrown when the credentials passed with the request are
    /// invalid or expired. Also thrown when the credentials in the request do
    /// not have permission to access the `StartConversation`
    /// operation.
    access_denied_exception: ?AccessDeniedException,
    audio_response_event: ?AudioResponseEvent,
    bad_gateway_exception: ?BadGatewayException,
    /// Exception thrown when two clients are using the same AWS account,
    /// Amazon Lex V2 bot, and session ID.
    conflict_exception: ?ConflictException,
    dependency_failed_exception: ?DependencyFailedException,
    heartbeat_event: ?HeartbeatEvent,
    /// Event sent from Amazon Lex V2 to the client application containing the
    /// current state of the conversation between the user and Amazon Lex V2.
    intent_result_event: ?IntentResultEvent,
    /// An error occurred with Amazon Lex V2.
    internal_server_exception: ?InternalServerException,
    playback_interruption_event: ?PlaybackInterruptionEvent,
    /// Exception thrown if one of the input parameters points to a resource
    /// that does not exist. For example, if the bot ID specified does not
    /// exist.
    resource_not_found_exception: ?ResourceNotFoundException,
    text_response_event: ?TextResponseEvent,
    /// Exception thrown when your application exceeds the maximum number of
    /// concurrent requests.
    throttling_exception: ?ThrottlingException,
    transcript_event: ?TranscriptEvent,
    /// Exception thrown when one or more parameters could not be validated.
    /// The `message` contains the name of the field that isn't
    /// valid.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "AccessDeniedException",
        .audio_response_event = "AudioResponseEvent",
        .bad_gateway_exception = "BadGatewayException",
        .conflict_exception = "ConflictException",
        .dependency_failed_exception = "DependencyFailedException",
        .heartbeat_event = "HeartbeatEvent",
        .intent_result_event = "IntentResultEvent",
        .internal_server_exception = "InternalServerException",
        .playback_interruption_event = "PlaybackInterruptionEvent",
        .resource_not_found_exception = "ResourceNotFoundException",
        .text_response_event = "TextResponseEvent",
        .throttling_exception = "ThrottlingException",
        .transcript_event = "TranscriptEvent",
        .validation_exception = "ValidationException",
    };
};
