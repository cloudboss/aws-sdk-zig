const PluginConfiguration = @import("plugin_configuration.zig").PluginConfiguration;

/// Configuration information for Amazon Q Business conversation modes.
///
/// For more information, see [Admin controls and
/// guardrails](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails.html) and [Conversation settings](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/using-web-experience.html#chat-source-scope).
pub const ChatModeConfiguration = union(enum) {
    /// Configuration information required to invoke chat in `PLUGIN_MODE`.
    plugin_configuration: ?PluginConfiguration,

    pub const json_field_names = .{
        .plugin_configuration = "pluginConfiguration",
    };
};
