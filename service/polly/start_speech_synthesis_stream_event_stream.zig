const AudioEvent = @import("audio_event.zig").AudioEvent;
const ServiceFailureException = @import("errors.zig").ServiceFailureException;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const StreamClosedEvent = @import("stream_closed_event.zig").StreamClosedEvent;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// Outbound event stream that contains synthesized audio data and stream status
/// events.
pub const StartSpeechSynthesisStreamEventStream = union(enum) {
    /// An audio event containing synthesized speech.
    audio_event: ?AudioEvent,
    service_failure_exception: ?ServiceFailureException,
    /// An exception indicating a service quota would be exceeded.
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    /// An event, with summary information, indicating the stream has closed.
    stream_closed_event: ?StreamClosedEvent,
    /// An exception indicating the request was throttled.
    throttling_exception: ?ThrottlingException,
    /// An exception indicating the input failed validation.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .audio_event = "AudioEvent",
        .service_failure_exception = "ServiceFailureException",
        .service_quota_exceeded_exception = "ServiceQuotaExceededException",
        .stream_closed_event = "StreamClosedEvent",
        .throttling_exception = "ThrottlingException",
        .validation_exception = "ValidationException",
    };
};
