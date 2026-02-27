const BidirectionalOutputPayloadPart = @import("bidirectional_output_payload_part.zig").BidirectionalOutputPayloadPart;
const InternalServerException = @import("errors.zig").InternalServerException;
const ModelStreamErrorException = @import("errors.zig").ModelStreamErrorException;
const ModelTimeoutException = @import("errors.zig").ModelTimeoutException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// Output from the bidirectional stream that was used for model invocation.
pub const InvokeModelWithBidirectionalStreamOutput = union(enum) {
    /// The speech chunk that was provided as output from the invocation step.
    chunk: ?BidirectionalOutputPayloadPart,
    /// The request encountered an unknown internal error.
    internal_server_exception: ?InternalServerException,
    /// The request encountered an error with the model stream.
    model_stream_error_exception: ?ModelStreamErrorException,
    /// The connection was closed because a request was not received within the
    /// timeout period.
    model_timeout_exception: ?ModelTimeoutException,
    /// The request has failed due to a temporary failure of the server.
    service_unavailable_exception: ?ServiceUnavailableException,
    /// The request was denied due to request throttling.
    throttling_exception: ?ThrottlingException,
    /// The input fails to satisfy the constraints specified by an Amazon Web
    /// Services service.
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
