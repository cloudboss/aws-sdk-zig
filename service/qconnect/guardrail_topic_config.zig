const GuardrailTopicType = @import("guardrail_topic_type.zig").GuardrailTopicType;

/// Details about topics for the AI Guardrail to identify and deny.
pub const GuardrailTopicConfig = struct {
    /// A definition of the topic to deny.
    definition: []const u8,

    /// A list of prompts, each of which is an example of a prompt that can be
    /// categorized as belonging to the topic.
    examples: ?[]const []const u8 = null,

    /// The name of the topic to deny.
    name: []const u8,

    /// Specifies to deny the topic.
    @"type": GuardrailTopicType,

    pub const json_field_names = .{
        .definition = "definition",
        .examples = "examples",
        .name = "name",
        .@"type" = "type",
    };
};
