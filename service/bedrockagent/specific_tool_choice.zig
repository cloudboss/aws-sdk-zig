/// Defines a specific tool that the model must request. No text is generated
/// but the results of tool use are sent back to the model to help generate a
/// response. For more information, see [Use a tool to complete an Amazon
/// Bedrock model
/// response](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html).
pub const SpecificToolChoice = struct {
    /// The name of the tool.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
