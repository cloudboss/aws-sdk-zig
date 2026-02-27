const GuardrailTopicAction = @import("guardrail_topic_action.zig").GuardrailTopicAction;
const GuardrailTopicType = @import("guardrail_topic_type.zig").GuardrailTopicType;

/// Details about topics for the guardrail to identify and deny.
///
/// This data type is used in the following API operations:
///
/// * [GetGuardrail response
///   body](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax)
pub const GuardrailTopic = struct {
    /// A definition of the topic to deny.
    definition: []const u8,

    /// A list of prompts, each of which is an example of a prompt that can be
    /// categorized as belonging to the topic.
    examples: ?[]const []const u8,

    /// The action to take when harmful content is detected in the input. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailTopicAction,

    /// Indicates whether guardrail evaluation is enabled on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool,

    /// The name of the topic to deny.
    name: []const u8,

    /// The action to take when harmful content is detected in the output. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailTopicAction,

    /// Indicates whether guardrail evaluation is enabled on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool,

    /// Specifies to deny the topic.
    type: ?GuardrailTopicType,

    pub const json_field_names = .{
        .definition = "definition",
        .examples = "examples",
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .name = "name",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .type = "type",
    };
};
