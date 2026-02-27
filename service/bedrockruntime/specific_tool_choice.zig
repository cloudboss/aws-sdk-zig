/// The model must request a specific tool. For example, `{"tool" : {"name" :
/// "Your tool name"}}`. For more information, see [Call a tool with the
/// Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide
///
/// This field is only supported by Anthropic Claude 3 models.
pub const SpecificToolChoice = struct {
    /// The name of the tool that the model must request.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
