const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const BadGatewayException = @import("errors.zig").BadGatewayException;
const ConflictException = @import("errors.zig").ConflictException;
const DependencyFailedException = @import("errors.zig").DependencyFailedException;
const FlowCompletionEvent = @import("flow_completion_event.zig").FlowCompletionEvent;
const FlowMultiTurnInputRequestEvent = @import("flow_multi_turn_input_request_event.zig").FlowMultiTurnInputRequestEvent;
const FlowOutputEvent = @import("flow_output_event.zig").FlowOutputEvent;
const FlowTraceEvent = @import("flow_trace_event.zig").FlowTraceEvent;
const InternalServerException = @import("errors.zig").InternalServerException;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// The output of the flow.
pub const FlowResponseStream = union(enum) {
    /// The request is denied because of missing access permissions. Check your
    /// permissions and retry your request.
    access_denied_exception: ?AccessDeniedException,
    /// There was an issue with a dependency due to a server issue. Retry your
    /// request.
    bad_gateway_exception: ?BadGatewayException,
    /// There was a conflict performing an operation. Resolve the conflict and retry
    /// your request.
    conflict_exception: ?ConflictException,
    /// There was an issue with a dependency. Check the resource configurations and
    /// retry the request.
    dependency_failed_exception: ?DependencyFailedException,
    /// Contains information about why the flow completed.
    flow_completion_event: ?FlowCompletionEvent,
    /// The event stream containing the multi-turn input request information from
    /// the flow.
    flow_multi_turn_input_request_event: ?FlowMultiTurnInputRequestEvent,
    /// Contains information about an output from flow invocation.
    flow_output_event: ?FlowOutputEvent,
    /// Contains information about a trace, which tracks an input or output for a
    /// node in the flow.
    flow_trace_event: ?FlowTraceEvent,
    /// An internal server error occurred. Retry your request.
    internal_server_exception: ?InternalServerException,
    /// The specified resource Amazon Resource Name (ARN) was not found. Check the
    /// Amazon Resource Name (ARN) and try your request again.
    resource_not_found_exception: ?ResourceNotFoundException,
    /// The number of requests exceeds the service quota. Resubmit your request
    /// later.
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    /// The number of requests exceeds the limit. Resubmit your request later.
    throttling_exception: ?ThrottlingException,
    /// Input validation failed. Check your request parameters and retry the
    /// request.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .bad_gateway_exception = "badGatewayException",
        .conflict_exception = "conflictException",
        .dependency_failed_exception = "dependencyFailedException",
        .flow_completion_event = "flowCompletionEvent",
        .flow_multi_turn_input_request_event = "flowMultiTurnInputRequestEvent",
        .flow_output_event = "flowOutputEvent",
        .flow_trace_event = "flowTraceEvent",
        .internal_server_exception = "internalServerException",
        .resource_not_found_exception = "resourceNotFoundException",
        .service_quota_exceeded_exception = "serviceQuotaExceededException",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
