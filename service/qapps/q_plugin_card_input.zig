const CardType = @import("card_type.zig").CardType;

/// The input shape for defining a plugin card in an Amazon Q App.
pub const QPluginCardInput = struct {
    /// The action identifier of the action to be performed by the plugin card.
    action_identifier: ?[]const u8,

    /// The unique identifier of the plugin card.
    id: []const u8,

    /// The unique identifier of the plugin used by the card.
    plugin_id: []const u8,

    /// The prompt or instructions displayed for the plugin card.
    prompt: []const u8,

    /// The title or label of the plugin card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType = "q-plugin",

    pub const json_field_names = .{
        .action_identifier = "actionIdentifier",
        .id = "id",
        .plugin_id = "pluginId",
        .prompt = "prompt",
        .title = "title",
        .@"type" = "type",
    };
};
