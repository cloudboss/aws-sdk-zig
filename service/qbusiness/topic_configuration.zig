const Rule = @import("rule.zig").Rule;

/// The topic specific controls configured for an Amazon Q Business application.
pub const TopicConfiguration = struct {
    /// A description for your topic control configuration. Use this to outline how
    /// the large language model (LLM) should use this topic control configuration.
    description: ?[]const u8,

    /// A list of example phrases that you expect the end user to use in relation to
    /// the topic.
    example_chat_messages: ?[]const []const u8,

    /// A name for your topic control configuration.
    name: []const u8,

    /// Rules defined for a topic configuration.
    rules: []const Rule,

    pub const json_field_names = .{
        .description = "description",
        .example_chat_messages = "exampleChatMessages",
        .name = "name",
        .rules = "rules",
    };
};
