const PluginType = @import("plugin_type.zig").PluginType;
const CardType = @import("card_type.zig").CardType;

/// A card in an Q App that integrates with a third-party plugin or service.
pub const QPluginCard = struct {
    /// The action identifier of the action to be performed by the plugin card.
    action_identifier: ?[]const u8,

    /// Any dependencies or requirements for the plugin card.
    dependencies: []const []const u8,

    /// The unique identifier of the plugin card.
    id: []const u8,

    /// The unique identifier of the plugin used by the card.
    plugin_id: []const u8,

    /// The type or category of the plugin used by the card.
    plugin_type: PluginType,

    /// The prompt or instructions displayed for the plugin card.
    prompt: []const u8,

    /// The title or label of the plugin card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType,

    pub const json_field_names = .{
        .action_identifier = "actionIdentifier",
        .dependencies = "dependencies",
        .id = "id",
        .plugin_id = "pluginId",
        .plugin_type = "pluginType",
        .prompt = "prompt",
        .title = "title",
        .@"type" = "type",
    };
};
