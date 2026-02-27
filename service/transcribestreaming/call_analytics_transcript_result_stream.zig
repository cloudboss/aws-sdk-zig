const BadRequestException = @import("errors.zig").BadRequestException;
const CategoryEvent = @import("category_event.zig").CategoryEvent;
const ConflictException = @import("errors.zig").ConflictException;
const InternalFailureException = @import("errors.zig").InternalFailureException;
const LimitExceededException = @import("errors.zig").LimitExceededException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const UtteranceEvent = @import("utterance_event.zig").UtteranceEvent;

/// Contains detailed information about your real-time Call Analytics session.
/// These details are
/// provided in the `UtteranceEvent` and `CategoryEvent` objects.
pub const CallAnalyticsTranscriptResultStream = union(enum) {
    bad_request_exception: ?BadRequestException,
    /// Provides information on matched categories that were used to generate
    /// real-time supervisor
    /// alerts.
    category_event: ?CategoryEvent,
    conflict_exception: ?ConflictException,
    internal_failure_exception: ?InternalFailureException,
    limit_exceeded_exception: ?LimitExceededException,
    service_unavailable_exception: ?ServiceUnavailableException,
    /// Contains set of transcription results from one or more audio segments, along
    /// with additional
    /// information per your request parameters. This can include information
    /// relating to channel definitions,
    /// partial result stabilization, sentiment, issue detection, and other
    /// transcription-related data.
    utterance_event: ?UtteranceEvent,

    pub const json_field_names = .{
        .bad_request_exception = "BadRequestException",
        .category_event = "CategoryEvent",
        .conflict_exception = "ConflictException",
        .internal_failure_exception = "InternalFailureException",
        .limit_exceeded_exception = "LimitExceededException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .utterance_event = "UtteranceEvent",
    };
};
