const BadRequestException = @import("errors.zig").BadRequestException;
const ConflictException = @import("errors.zig").ConflictException;
const InternalFailureException = @import("errors.zig").InternalFailureException;
const LimitExceededException = @import("errors.zig").LimitExceededException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const MedicalTranscriptEvent = @import("medical_transcript_event.zig").MedicalTranscriptEvent;

/// Contains detailed information about your streaming session.
pub const MedicalTranscriptResultStream = union(enum) {
    bad_request_exception: ?BadRequestException,
    conflict_exception: ?ConflictException,
    internal_failure_exception: ?InternalFailureException,
    limit_exceeded_exception: ?LimitExceededException,
    service_unavailable_exception: ?ServiceUnavailableException,
    /// The `MedicalTranscriptEvent` associated with a
    /// `MedicalTranscriptResultStream`.
    ///
    /// Contains a set of transcription results from one or more audio segments,
    /// along with
    /// additional information per your request parameters. This can include
    /// information relating to
    /// alternative transcriptions, channel identification, partial result
    /// stabilization, language
    /// identification, and other transcription-related data.
    transcript_event: ?MedicalTranscriptEvent,

    pub const json_field_names = .{
        .bad_request_exception = "BadRequestException",
        .conflict_exception = "ConflictException",
        .internal_failure_exception = "InternalFailureException",
        .limit_exceeded_exception = "LimitExceededException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .transcript_event = "TranscriptEvent",
    };
};
