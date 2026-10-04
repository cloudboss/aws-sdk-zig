const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const BadGatewayException = @import("errors.zig").BadGatewayException;
const ConflictException = @import("errors.zig").ConflictException;
const DependencyFailedException = @import("errors.zig").DependencyFailedException;
const InternalServerException = @import("errors.zig").InternalServerException;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const AgenticRetrieveResponseEvent = @import("agentic_retrieve_response_event.zig").AgenticRetrieveResponseEvent;
const AgenticRetrieveResultEvent = @import("agentic_retrieve_result_event.zig").AgenticRetrieveResultEvent;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const AgenticRetrieveTraceEvent = @import("agentic_retrieve_trace_event.zig").AgenticRetrieveTraceEvent;
const ValidationException = @import("errors.zig").ValidationException;

/// The streaming output for agentic retrieval, containing results, traces, and
/// errors.
pub const AgenticRetrieveStreamResponseOutput = union(enum) {
    /// Access to the resource was denied.
    access_denied_exception: ?AccessDeniedException,
    /// A bad gateway error occurred.
    bad_gateway_exception: ?BadGatewayException,
    /// A conflict occurred with the current state of the resource.
    conflict_exception: ?ConflictException,
    /// A dependency failed during the operation.
    dependency_failed_exception: ?DependencyFailedException,
    /// An internal server error occurred.
    internal_server_exception: ?InternalServerException,
    /// The specified resource was not found.
    resource_not_found_exception: ?ResourceNotFoundException,
    /// A chunk of the generated answer. Emitted only when generateResponse is true.
    response_event: ?AgenticRetrieveResponseEvent,
    /// A retrieval result event containing the retrieved items.
    result: ?AgenticRetrieveResultEvent,
    /// The service quota has been exceeded.
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    /// The request was throttled.
    throttling_exception: ?ThrottlingException,
    /// A trace event providing visibility into the retrieval process.
    trace_event: ?AgenticRetrieveTraceEvent,
    /// The request validation failed.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .bad_gateway_exception = "badGatewayException",
        .conflict_exception = "conflictException",
        .dependency_failed_exception = "dependencyFailedException",
        .internal_server_exception = "internalServerException",
        .resource_not_found_exception = "resourceNotFoundException",
        .response_event = "responseEvent",
        .result = "result",
        .service_quota_exceeded_exception = "serviceQuotaExceededException",
        .throttling_exception = "throttlingException",
        .trace_event = "traceEvent",
        .validation_exception = "validationException",
    };
};
