const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;

/// Contains a system prompt to provide context to the model or to describe how
/// it should behave. For more information, see [Create a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html).
pub const SystemContentBlock = union(enum) {
    /// Creates a cache checkpoint within a tool designation
    cache_point: ?CachePointBlock,
    /// The text in the system prompt.
    text: ?[]const u8,

    pub const json_field_names = .{
        .cache_point = "cachePoint",
        .text = "text",
    };
};
