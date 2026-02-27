/// Configuration information required to invoke chat in `PLUGIN_MODE`.
///
/// For more information, see [Admin controls and
/// guardrails](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails.html), [Plugins](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/plugins.html), and [Conversation settings](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/using-web-experience.html#chat-source-scope).
pub const PluginConfiguration = struct {
    /// The identifier of the plugin you want to use.
    plugin_id: []const u8,

    pub const json_field_names = .{
        .plugin_id = "pluginId",
    };
};
