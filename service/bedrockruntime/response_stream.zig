const PayloadPart = @import("payload_part.zig").PayloadPart;
const InternalServerException = @import("errors.zig").InternalServerException;
const ModelStreamErrorException = @import("errors.zig").ModelStreamErrorException;
const ModelTimeoutException = @import("errors.zig").ModelTimeoutException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// Definition of content in the response stream.
pub const ResponseStream = union(enum) {
    /// Content included in the response.
    chunk: ?PayloadPart,
    /// An internal server error occurred. Retry your request.
    internal_server_exception: ?InternalServerException,
    /// An error occurred while streaming the response. Retry your request.
    model_stream_error_exception: ?ModelStreamErrorException,
    /// The request took too long to process. Processing time exceeded the model
    /// timeout length.
    model_timeout_exception: ?ModelTimeoutException,
    /// The service isn't available. Try again later.
    service_unavailable_exception: ?ServiceUnavailableException,
    /// Your request was throttled because of service-wide limitations. Resubmit
    /// your request later or in a different region. You can also purchase
    /// [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) to increase the rate or number of tokens you can process.
    throttling_exception: ?ThrottlingException,
    /// Input validation failed. Check your request parameters and retry the
    /// request.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .chunk = "chunk",
        .internal_server_exception = "internalServerException",
        .model_stream_error_exception = "modelStreamErrorException",
        .model_timeout_exception = "modelTimeoutException",
        .service_unavailable_exception = "serviceUnavailableException",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
