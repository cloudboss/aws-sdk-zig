const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const ConflictingOperationException = @import("errors.zig").ConflictingOperationException;
const InternalFailureException = @import("errors.zig").InternalFailureException;
const InvalidRequestException = @import("errors.zig").InvalidRequestException;
const LimitExceededException = @import("errors.zig").LimitExceededException;
const InvocationOutput = @import("invocation_output.zig").InvocationOutput;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const Trace = @import("trace.zig").Trace;

/// Contains the response, citation, and trace from the SiteWise Assistant.
pub const ResponseStream = union(enum) {
    access_denied_exception: ?AccessDeniedException,
    conflicting_operation_exception: ?ConflictingOperationException,
    internal_failure_exception: ?InternalFailureException,
    invalid_request_exception: ?InvalidRequestException,
    limit_exceeded_exception: ?LimitExceededException,
    /// Contains the SiteWise Assistant's response.
    output: ?InvocationOutput,
    resource_not_found_exception: ?ResourceNotFoundException,
    throttling_exception: ?ThrottlingException,
    /// Contains tracing information of the SiteWise Assistant's reasoning and data
    /// access.
    trace: ?Trace,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .conflicting_operation_exception = "conflictingOperationException",
        .internal_failure_exception = "internalFailureException",
        .invalid_request_exception = "invalidRequestException",
        .limit_exceeded_exception = "limitExceededException",
        .output = "output",
        .resource_not_found_exception = "resourceNotFoundException",
        .throttling_exception = "throttlingException",
        .trace = "trace",
    };
};
