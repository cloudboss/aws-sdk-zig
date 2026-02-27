pub const PluginHealth = enum {
    plugin_healthy,
    plugin_unhealthy,

    pub const json_field_names = .{
        .plugin_healthy = "PLUGIN_HEALTHY",
        .plugin_unhealthy = "PLUGIN_UNHEALTHY",
    };
};
