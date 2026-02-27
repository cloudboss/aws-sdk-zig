const InternalStreamFailure = @import("errors.zig").InternalStreamFailure;
const ModelStreamError = @import("errors.zig").ModelStreamError;
const PayloadPart = @import("payload_part.zig").PayloadPart;

/// A stream of payload parts. Each part contains a portion of the response for
/// a
/// streaming inference request.
pub const ResponseStream = union(enum) {
    /// The stream processing failed because of an unknown error, exception or
    /// failure. Try your request again.
    internal_stream_failure: ?InternalStreamFailure,
    /// An error occurred while streaming the response body. This error can have the
    /// following error codes:
    ///
    /// **ModelInvocationTimeExceeded**
    ///
    /// The model failed to finish sending the response within the timeout period
    /// allowed by Amazon SageMaker AI.
    ///
    /// **StreamBroken**
    ///
    /// The Transmission Control Protocol (TCP) connection between the client and
    /// the model was reset or closed.
    model_stream_error: ?ModelStreamError,
    /// A wrapper for pieces of the payload that's returned in response to a
    /// streaming
    /// inference request. A streaming inference response consists of one or more
    /// payload parts.
    payload_part: ?PayloadPart,

    pub const json_field_names = .{
        .internal_stream_failure = "InternalStreamFailure",
        .model_stream_error = "ModelStreamError",
        .payload_part = "PayloadPart",
    };
};
