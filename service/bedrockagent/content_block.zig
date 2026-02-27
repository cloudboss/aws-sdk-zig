const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;

/// Contains the content for the message you pass to, or receive from a model.
/// For more information, see [Create a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html).
pub const ContentBlock = union(enum) {
    /// Creates a cache checkpoint within a message.
    cache_point: ?CachePointBlock,
    /// The text in the message.
    text: ?[]const u8,

    pub const json_field_names = .{
        .cache_point = "cachePoint",
        .text = "text",
    };
};
