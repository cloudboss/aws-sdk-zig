const CustomPluginDescription = @import("custom_plugin_description.zig").CustomPluginDescription;

/// The description of the plugin.
pub const PluginDescription = struct {
    /// Details about a custom plugin.
    custom_plugin: ?CustomPluginDescription = null,

    pub const json_field_names = .{
        .custom_plugin = "customPlugin",
    };
};
