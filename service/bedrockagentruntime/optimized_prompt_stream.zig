const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const AnalyzePromptEvent = @import("analyze_prompt_event.zig").AnalyzePromptEvent;
const BadGatewayException = @import("errors.zig").BadGatewayException;
const DependencyFailedException = @import("errors.zig").DependencyFailedException;
const InternalServerException = @import("errors.zig").InternalServerException;
const OptimizedPromptEvent = @import("optimized_prompt_event.zig").OptimizedPromptEvent;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// The stream containing events in the prompt optimization process.
pub const OptimizedPromptStream = union(enum) {
    /// The request is denied because of missing access permissions. Check your
    /// permissions and retry your request.
    access_denied_exception: ?AccessDeniedException,
    /// An event in which the prompt was analyzed in preparation for optimization.
    analyze_prompt_event: ?AnalyzePromptEvent,
    /// There was an issue with a dependency due to a server issue. Retry your
    /// request.
    bad_gateway_exception: ?BadGatewayException,
    /// There was an issue with a dependency. Check the resource configurations and
    /// retry the request.
    dependency_failed_exception: ?DependencyFailedException,
    /// An internal server error occurred. Retry your request.
    internal_server_exception: ?InternalServerException,
    /// An event in which the prompt was optimized.
    optimized_prompt_event: ?OptimizedPromptEvent,
    /// Your request was throttled because of service-wide limitations. Resubmit
    /// your request later or in a different region. You can also purchase
    /// [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) to increase the rate or number of tokens you can process.
    throttling_exception: ?ThrottlingException,
    /// Input validation failed. Check your request parameters and retry the
    /// request.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .analyze_prompt_event = "analyzePromptEvent",
        .bad_gateway_exception = "badGatewayException",
        .dependency_failed_exception = "dependencyFailedException",
        .internal_server_exception = "internalServerException",
        .optimized_prompt_event = "optimizedPromptEvent",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
