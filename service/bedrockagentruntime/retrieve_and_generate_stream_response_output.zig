const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const BadGatewayException = @import("errors.zig").BadGatewayException;
const CitationEvent = @import("citation_event.zig").CitationEvent;
const ConflictException = @import("errors.zig").ConflictException;
const DependencyFailedException = @import("errors.zig").DependencyFailedException;
const GuardrailEvent = @import("guardrail_event.zig").GuardrailEvent;
const InternalServerException = @import("errors.zig").InternalServerException;
const RetrieveAndGenerateOutputEvent = @import("retrieve_and_generate_output_event.zig").RetrieveAndGenerateOutputEvent;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// A retrieve and generate stream response output.
pub const RetrieveAndGenerateStreamResponseOutput = union(enum) {
    /// The request is denied because you do not have sufficient permissions to
    /// perform the requested action. For troubleshooting this error, see
    /// [AccessDeniedException](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-access-denied) in the Amazon Bedrock User Guide.
    access_denied_exception: ?AccessDeniedException,
    /// The request failed due to a bad gateway error.
    bad_gateway_exception: ?BadGatewayException,
    /// A citation event.
    citation: ?CitationEvent,
    /// Error occurred because of a conflict while performing an operation.
    conflict_exception: ?ConflictException,
    /// The request failed due to a dependency error.
    dependency_failed_exception: ?DependencyFailedException,
    /// A guardrail event.
    guardrail: ?GuardrailEvent,
    /// An internal server error occurred. Retry your request.
    internal_server_exception: ?InternalServerException,
    /// An output event.
    output: ?RetrieveAndGenerateOutputEvent,
    /// The specified resource ARN was not found. For troubleshooting this error,
    /// see
    /// [ResourceNotFound](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-resource-not-found) in the Amazon Bedrock User Guide.
    resource_not_found_exception: ?ResourceNotFoundException,
    /// Your request exceeds the service quota for your account. You can view your
    /// quotas at [Viewing service
    /// quotas](https://docs.aws.amazon.com/servicequotas/latest/userguide/gs-request-quota.html). You can resubmit your request later.
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    /// Your request was denied due to exceeding the account quotas for *Amazon
    /// Bedrock*. For troubleshooting this error, see
    /// [ThrottlingException](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-throttling-exception) in the Amazon Bedrock User Guide.
    throttling_exception: ?ThrottlingException,
    /// The input fails to satisfy the constraints specified by *Amazon Bedrock*.
    /// For troubleshooting this error, see
    /// [ValidationError](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-validation-error) in the Amazon Bedrock User Guide.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .bad_gateway_exception = "badGatewayException",
        .citation = "citation",
        .conflict_exception = "conflictException",
        .dependency_failed_exception = "dependencyFailedException",
        .guardrail = "guardrail",
        .internal_server_exception = "internalServerException",
        .output = "output",
        .resource_not_found_exception = "resourceNotFoundException",
        .service_quota_exceeded_exception = "serviceQuotaExceededException",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
