/// The input schema for the tool. For more information, see [Use a tool to
/// complete an Amazon Bedrock model
/// response](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html).
pub const ToolInputSchema = union(enum) {
    /// A JSON object defining the input schema for the tool.
    json: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
    };
};
