const BidirectionalInputPayloadPart = @import("bidirectional_input_payload_part.zig").BidirectionalInputPayloadPart;

/// Payload content, the speech chunk, for the bidirectional input of the
/// invocation step.
pub const InvokeModelWithBidirectionalStreamInput = union(enum) {
    /// The audio chunk that is used as input for the invocation step.
    chunk: ?BidirectionalInputPayloadPart,

    pub const json_field_names = .{
        .chunk = "chunk",
    };
};
