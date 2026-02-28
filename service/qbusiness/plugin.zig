const PluginBuildStatus = @import("plugin_build_status.zig").PluginBuildStatus;
const PluginState = @import("plugin_state.zig").PluginState;
const PluginType = @import("plugin_type.zig").PluginType;

/// Information about an Amazon Q Business plugin and its configuration.
pub const Plugin = struct {
    /// The status of the plugin.
    build_status: ?PluginBuildStatus,

    /// The timestamp for when the plugin was created.
    created_at: ?i64,

    /// The name of the plugin.
    display_name: ?[]const u8,

    /// The identifier of the plugin.
    plugin_id: ?[]const u8,

    /// The plugin server URL used for configuration.
    server_url: ?[]const u8,

    /// The current status of the plugin.
    state: ?PluginState,

    /// The type of the plugin.
    @"type": ?PluginType,

    /// The timestamp for when the plugin was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .build_status = "buildStatus",
        .created_at = "createdAt",
        .display_name = "displayName",
        .plugin_id = "pluginId",
        .server_url = "serverUrl",
        .state = "state",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
