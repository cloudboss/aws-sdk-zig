const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const ResponseChunk = @import("response_chunk.zig").ResponseChunk;
const InternalServerException = @import("errors.zig").InternalServerException;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const RuntimeClientError = @import("errors.zig").RuntimeClientError;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// The streaming output union for the `InvokeAgentRuntimeCommand` operation.
/// This union delivers typed events: `contentStart` (first), `contentDelta`
/// (middle), and `contentStop` (last).
pub const InvokeAgentRuntimeCommandStreamOutput = union(enum) {
    /// Exception events for error streaming.
    access_denied_exception: ?AccessDeniedException,
    /// A response chunk containing command execution events such as content start,
    /// content delta, or content stop events.
    chunk: ?ResponseChunk,
    internal_server_exception: ?InternalServerException,
    resource_not_found_exception: ?ResourceNotFoundException,
    runtime_client_error: ?RuntimeClientError,
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    throttling_exception: ?ThrottlingException,
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .chunk = "chunk",
        .internal_server_exception = "internalServerException",
        .resource_not_found_exception = "resourceNotFoundException",
        .runtime_client_error = "runtimeClientError",
        .service_quota_exceeded_exception = "serviceQuotaExceededException",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
