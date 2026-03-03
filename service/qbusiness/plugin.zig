const PluginBuildStatus = @import("plugin_build_status.zig").PluginBuildStatus;
const PluginState = @import("plugin_state.zig").PluginState;
const PluginType = @import("plugin_type.zig").PluginType;

/// Information about an Amazon Q Business plugin and its configuration.
pub const Plugin = struct {
    /// The status of the plugin.
    build_status: ?PluginBuildStatus = null,

    /// The timestamp for when the plugin was created.
    created_at: ?i64 = null,

    /// The name of the plugin.
    display_name: ?[]const u8 = null,

    /// The identifier of the plugin.
    plugin_id: ?[]const u8 = null,

    /// The plugin server URL used for configuration.
    server_url: ?[]const u8 = null,

    /// The current status of the plugin.
    state: ?PluginState = null,

    /// The type of the plugin.
    @"type": ?PluginType = null,

    /// The timestamp for when the plugin was last updated.
    updated_at: ?i64 = null,

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
