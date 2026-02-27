const BadRequestException = @import("errors.zig").BadRequestException;
const ConflictException = @import("errors.zig").ConflictException;
const InternalFailureException = @import("errors.zig").InternalFailureException;
const LimitExceededException = @import("errors.zig").LimitExceededException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const MedicalScribeTranscriptEvent = @import("medical_scribe_transcript_event.zig").MedicalScribeTranscriptEvent;

/// Result stream where you will receive the output events.
/// The details are provided in the `MedicalScribeTranscriptEvent` object.
pub const MedicalScribeResultStream = union(enum) {
    bad_request_exception: ?BadRequestException,
    conflict_exception: ?ConflictException,
    internal_failure_exception: ?InternalFailureException,
    limit_exceeded_exception: ?LimitExceededException,
    service_unavailable_exception: ?ServiceUnavailableException,
    /// The transcript event that contains real-time transcription results.
    transcript_event: ?MedicalScribeTranscriptEvent,

    pub const json_field_names = .{
        .bad_request_exception = "BadRequestException",
        .conflict_exception = "ConflictException",
        .internal_failure_exception = "InternalFailureException",
        .limit_exceeded_exception = "LimitExceededException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .transcript_event = "TranscriptEvent",
    };
};
