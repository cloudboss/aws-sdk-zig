const aws = @import("aws");

/// Information about a prompt.
pub const Prompt = struct {
    /// The description of the prompt.
    description: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the prompt.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the prompt.
    prompt_arn: ?[]const u8,

    /// A unique identifier for the prompt.
    prompt_id: ?[]const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

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
