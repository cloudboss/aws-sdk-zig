/// Contains a key-value pair that defines a metadata tag and value to attach to
/// a prompt variant. For more information, see [Create a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html).
pub const PromptMetadataEntry = struct {
    /// The key of a metadata tag for a prompt variant.
    key: []const u8,

    /// The value of a metadata tag for a prompt variant.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
