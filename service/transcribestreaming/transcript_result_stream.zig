const BadRequestException = @import("errors.zig").BadRequestException;
const ConflictException = @import("errors.zig").ConflictException;
const InternalFailureException = @import("errors.zig").InternalFailureException;
const LimitExceededException = @import("errors.zig").LimitExceededException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const TranscriptEvent = @import("transcript_event.zig").TranscriptEvent;

/// Contains detailed information about your streaming session.
pub const TranscriptResultStream = union(enum) {
    /// A client error occurred when the stream was created. Check the parameters of
    /// the request
    /// and try your request again.
    bad_request_exception: ?BadRequestException,
    /// A new stream started with the same session ID. The current stream has been
    /// terminated.
    conflict_exception: ?ConflictException,
    /// A problem occurred while processing the audio. Amazon Transcribe terminated
    /// processing.
    internal_failure_exception: ?InternalFailureException,
    /// Your client has exceeded one of the Amazon Transcribe limits. This is
    /// typically the audio length
    /// limit. Break your audio stream into smaller chunks and try your request
    /// again.
    limit_exceeded_exception: ?LimitExceededException,
    /// The service is currently unavailable. Try your request later.
    service_unavailable_exception: ?ServiceUnavailableException,
    /// Contains `Transcript`, which contains `Results`. The
    /// `` object contains a set of transcription
    /// results from one or more audio segments, along with additional information
    /// per your request
    /// parameters.
    transcript_event: ?TranscriptEvent,

    pub const json_field_names = .{
        .bad_request_exception = "BadRequestException",
        .conflict_exception = "ConflictException",
        .internal_failure_exception = "InternalFailureException",
        .limit_exceeded_exception = "LimitExceededException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .transcript_event = "TranscriptEvent",
    };
};
