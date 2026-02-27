const InternalStreamFailure = @import("errors.zig").InternalStreamFailure;
const ModelStreamError = @import("errors.zig").ModelStreamError;
const ResponsePayloadPart = @import("response_payload_part.zig").ResponsePayloadPart;

/// Response stream event union.
pub const ResponseStreamEvent = union(enum) {
    /// Internal stream failure event.
    internal_stream_failure: ?InternalStreamFailure,
    /// Model stream error event.
    model_stream_error: ?ModelStreamError,
    /// Payload part event.
    payload_part: ?ResponsePayloadPart,

    pub const json_field_names = .{
        .internal_stream_failure = "InternalStreamFailure",
        .model_stream_error = "ModelStreamError",
        .payload_part = "PayloadPart",
    };
};
