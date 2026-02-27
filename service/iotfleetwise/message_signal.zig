const StructuredMessage = @import("structured_message.zig").StructuredMessage;

/// The decoding information for a specific message which support higher order
/// data types.
pub const MessageSignal = struct {
    /// The structured message for the message signal. It can be defined with either
    /// a
    /// `primitiveMessageDefinition`,
    /// `structuredMessageListDefinition`, or
    /// `structuredMessageDefinition` recursively.
    structured_message: StructuredMessage,

    /// The topic name for the message signal. It corresponds to topics in ROS 2.
    topic_name: []const u8,

    pub const json_field_names = .{
        .structured_message = "structuredMessage",
        .topic_name = "topicName",
    };
};
