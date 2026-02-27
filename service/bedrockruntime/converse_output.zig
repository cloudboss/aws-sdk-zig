const Message = @import("message.zig").Message;

/// The output from a call to
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html).
pub const ConverseOutput = union(enum) {
    /// The message that the model generates.
    message: ?Message,

    pub const json_field_names = .{
        .message = "message",
    };
};
