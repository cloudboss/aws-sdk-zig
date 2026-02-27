const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const BadGatewayException = @import("errors.zig").BadGatewayException;
const PayloadPart = @import("payload_part.zig").PayloadPart;
const ConflictException = @import("errors.zig").ConflictException;
const DependencyFailedException = @import("errors.zig").DependencyFailedException;
const FilePart = @import("file_part.zig").FilePart;
const InternalServerException = @import("errors.zig").InternalServerException;
const ModelNotReadyException = @import("errors.zig").ModelNotReadyException;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const ReturnControlPayload = @import("return_control_payload.zig").ReturnControlPayload;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const TracePart = @import("trace_part.zig").TracePart;
const ValidationException = @import("errors.zig").ValidationException;

/// The response from invoking the agent and associated citations and trace
/// information.
pub const ResponseStream = union(enum) {
    /// The request is denied because of missing access permissions. Check your
    /// permissions and retry your request.
    access_denied_exception: ?AccessDeniedException,
    /// There was an issue with a dependency due to a server issue. Retry your
    /// request.
    bad_gateway_exception: ?BadGatewayException,
    /// Contains a part of an agent response and citations for it.
    chunk: ?PayloadPart,
    /// There was a conflict performing an operation. Resolve the conflict and retry
    /// your request.
    conflict_exception: ?ConflictException,
    /// There was an issue with a dependency. Check the resource configurations and
    /// retry the request.
    dependency_failed_exception: ?DependencyFailedException,
    /// Contains intermediate response for code interpreter if any files have been
    /// generated.
    files: ?FilePart,
    /// An internal server error occurred. Retry your request.
    internal_server_exception: ?InternalServerException,
    /// The model specified in the request is not ready to serve Inference requests.
    /// The AWS SDK will automatically retry the operation up to 5 times. For
    /// information about configuring automatic retries, see [Retry
    /// behavior](https://docs.aws.amazon.com/sdkref/latest/guide/feature-retry-behavior.html) in the *AWS SDKs and Tools* reference guide.
    model_not_ready_exception: ?ModelNotReadyException,
    /// The specified resource Amazon Resource Name (ARN) was not found. Check the
    /// Amazon Resource Name (ARN) and try your request again.
    resource_not_found_exception: ?ResourceNotFoundException,
    /// Contains the parameters and information that the agent elicited from the
    /// customer to carry out an action. This information is returned to the system
    /// and can be used in your own setup for fulfilling the action.
    return_control: ?ReturnControlPayload,
    /// The number of requests exceeds the service quota. Resubmit your request
    /// later.
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    /// The number of requests exceeds the limit. Resubmit your request later.
    throttling_exception: ?ThrottlingException,
    /// Contains information about the agent and session, alongside the agent's
    /// reasoning process and results from calling actions and querying knowledge
    /// bases and metadata about the trace. You can use the trace to understand how
    /// the agent arrived at the response it provided the customer. For more
    /// information, see [Trace
    /// events](https://docs.aws.amazon.com/bedrock/latest/userguide/trace-events.html).
    trace: ?TracePart,
    /// Input validation failed. Check your request parameters and retry the
    /// request.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .bad_gateway_exception = "badGatewayException",
        .chunk = "chunk",
        .conflict_exception = "conflictException",
        .dependency_failed_exception = "dependencyFailedException",
        .files = "files",
        .internal_server_exception = "internalServerException",
        .model_not_ready_exception = "modelNotReadyException",
        .resource_not_found_exception = "resourceNotFoundException",
        .return_control = "returnControl",
        .service_quota_exceeded_exception = "serviceQuotaExceededException",
        .throttling_exception = "throttlingException",
        .trace = "trace",
        .validation_exception = "validationException",
    };
};
