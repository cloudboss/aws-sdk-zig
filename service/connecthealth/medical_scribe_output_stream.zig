const InternalServerException = @import("errors.zig").InternalServerException;
const MedicalScribeTranscriptEvent = @import("medical_scribe_transcript_event.zig").MedicalScribeTranscriptEvent;
const ValidationException = @import("errors.zig").ValidationException;

/// Output stream from Medical Scribe containing transcript events and errors
pub const MedicalScribeOutputStream = union(enum) {
    internal_failure_exception: ?InternalServerException,
    transcript_event: ?MedicalScribeTranscriptEvent,
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .internal_failure_exception = "internalFailureException",
        .transcript_event = "transcriptEvent",
        .validation_exception = "validationException",
    };
};
