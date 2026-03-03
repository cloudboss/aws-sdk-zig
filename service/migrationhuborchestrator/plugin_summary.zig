const PluginHealth = @import("plugin_health.zig").PluginHealth;

/// The summary of the Migration Hub Orchestrator plugin.
pub const PluginSummary = struct {
    /// The name of the host.
    hostname: ?[]const u8 = null,

    /// The IP address at which the plugin is located.
    ip_address: ?[]const u8 = null,

    /// The ID of the plugin.
    plugin_id: ?[]const u8 = null,

    /// The time at which the plugin was registered.
    registered_time: ?[]const u8 = null,

    /// The status of the plugin.
    status: ?PluginHealth = null,

    /// The version of the plugin.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .hostname = "hostname",
        .ip_address = "ipAddress",
        .plugin_id = "pluginId",
        .registered_time = "registeredTime",
        .status = "status",
        .version = "version",
    };
};
