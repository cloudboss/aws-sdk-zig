const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const ChatMode = @import("chat_mode.zig").ChatMode;
const ChatModeConfiguration = @import("chat_mode_configuration.zig").ChatModeConfiguration;

/// A configuration event activated by an end user request to select a specific
/// chat mode.
pub const ConfigurationEvent = struct {
    attribute_filter: ?AttributeFilter = null,

    /// The chat modes available to an Amazon Q Business end user.
    ///
    /// * `RETRIEVAL_MODE` - The default chat mode for an Amazon Q Business
    ///   application. When this mode is enabled, Amazon Q Business generates
    ///   responses only from data sources connected to an Amazon Q Business
    ///   application.
    /// * `CREATOR_MODE` - By selecting this mode, users can choose to generate
    ///   responses only from the LLM knowledge, without consulting connected data
    ///   sources, for a chat request.
    /// * `PLUGIN_MODE` - By selecting this mode, users can choose to use plugins in
    ///   chat.
    ///
    /// For more information, see [Admin controls and
    /// guardrails](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails.html), [Plugins](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/plugins.html), and [Conversation settings](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/using-web-experience.html#chat-source-scope).
    chat_mode: ?ChatMode = null,

    chat_mode_configuration: ?ChatModeConfiguration = null,

    pub const json_field_names = .{
        .attribute_filter = "attributeFilter",
        .chat_mode = "chatMode",
        .chat_mode_configuration = "chatModeConfiguration",
    };
};
