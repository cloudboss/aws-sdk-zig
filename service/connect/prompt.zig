const aws = @import("aws");

/// Information about a prompt.
pub const Prompt = struct {
    /// The description of the prompt.
    description: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the prompt.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the prompt.
    prompt_arn: ?[]const u8 = null,

    /// A unique identifier for the prompt.
    prompt_id: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .prompt_arn = "PromptARN",
        .prompt_id = "PromptId",
        .tags = "Tags",
    };
};
