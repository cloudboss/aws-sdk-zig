const ConverseStreamOutput = @import("converse_stream_output.zig").ConverseStreamOutput;

pub const ConverseStreamResponse = struct {
    /// The output stream that the model generated.
    stream: ?ConverseStreamOutput = null,

    pub const json_field_names = .{
        .stream = "stream",
    };
};
