const ContentBlockDeltaEvent = @import("content_block_delta_event.zig").ContentBlockDeltaEvent;
const ContentBlockStartEvent = @import("content_block_start_event.zig").ContentBlockStartEvent;
const ContentBlockStopEvent = @import("content_block_stop_event.zig").ContentBlockStopEvent;
const InternalServerException = @import("errors.zig").InternalServerException;
const MessageStartEvent = @import("message_start_event.zig").MessageStartEvent;
const MessageStopEvent = @import("message_stop_event.zig").MessageStopEvent;
const ConverseStreamMetadataEvent = @import("converse_stream_metadata_event.zig").ConverseStreamMetadataEvent;
const ModelStreamErrorException = @import("errors.zig").ModelStreamErrorException;
const ServiceUnavailableException = @import("errors.zig").ServiceUnavailableException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// The messages output stream
pub const ConverseStreamOutput = union(enum) {
    /// The messages output content block delta.
    content_block_delta: ?ContentBlockDeltaEvent,
    /// Start information for a content block.
    content_block_start: ?ContentBlockStartEvent,
    /// Stop information for a content block.
    content_block_stop: ?ContentBlockStopEvent,
    /// An internal server error occurred. Retry your request.
    internal_server_exception: ?InternalServerException,
    /// Message start information.
    message_start: ?MessageStartEvent,
    /// Message stop information.
    message_stop: ?MessageStopEvent,
    /// Metadata for the converse output stream.
    metadata: ?ConverseStreamMetadataEvent,
    /// A streaming error occurred. Retry your request.
    model_stream_error_exception: ?ModelStreamErrorException,
    /// The service isn't currently available. For troubleshooting this error, see
    /// [ServiceUnavailable](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-service-unavailable) in the Amazon Bedrock User Guide
    service_unavailable_exception: ?ServiceUnavailableException,
    /// Your request was denied due to exceeding the account quotas for *Amazon
    /// Bedrock*. For troubleshooting this error, see
    /// [ThrottlingException](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-throttling-exception) in the Amazon Bedrock User Guide.
    throttling_exception: ?ThrottlingException,
    /// The input fails to satisfy the constraints specified by *Amazon Bedrock*.
    /// For troubleshooting this error, see
    /// [ValidationError](https://docs.aws.amazon.com/bedrock/latest/userguide/troubleshooting-api-error-codes.html#ts-validation-error) in the Amazon Bedrock User Guide.
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .content_block_delta = "contentBlockDelta",
        .content_block_start = "contentBlockStart",
        .content_block_stop = "contentBlockStop",
        .internal_server_exception = "internalServerException",
        .message_start = "messageStart",
        .message_stop = "messageStop",
        .metadata = "metadata",
        .model_stream_error_exception = "modelStreamErrorException",
        .service_unavailable_exception = "serviceUnavailableException",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
