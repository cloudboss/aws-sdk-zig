/// Contains a map of variables in a prompt from Prompt management to an object
/// containing the values to fill in for them when running model invocation. For
/// more information, see [How Prompt management
/// works](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-how.html).
pub const PromptVariableValues = union(enum) {
    /// The text value that the variable maps to.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
