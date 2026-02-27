/// Contains information about a prompt in your Prompt management tool.
///
/// This data type is used in the following API operations:
///
/// * [ListPrompts
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_ListPrompts.html#API_agent_ListPrompts_ResponseSyntax)
pub const PromptSummary = struct {
    /// The Amazon Resource Name (ARN) of the prompt or the prompt version (if you
    /// specified a version in the request).
    arn: []const u8,

    /// The time at which the prompt was created.
    created_at: i64,

    /// The description of the prompt.
    description: ?[]const u8,

    /// The unique identifier of the prompt.
    id: []const u8,

    /// The name of the prompt.
    name: []const u8,

    /// The time at which the prompt was last updated.
    updated_at: i64,

    /// The version of the prompt that this summary applies to.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .name = "name",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
