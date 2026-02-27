const InvokeModelWithBidirectionalStreamOutput = @import("invoke_model_with_bidirectional_stream_output.zig").InvokeModelWithBidirectionalStreamOutput;

pub const InvokeModelWithBidirectionalStreamResponse = struct {
    /// Streaming response from the model in the format specified by the
    /// `BidirectionalOutputPayloadPart` header.
    body: InvokeModelWithBidirectionalStreamOutput,

    pub const json_field_names = .{
        .body = "body",
    };
};
