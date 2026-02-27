const CustomPlugin = @import("custom_plugin.zig").CustomPlugin;

/// A plugin is an Amazon Web Services resource that contains the code that
/// defines your connector logic.
pub const Plugin = struct {
    /// Details about a custom plugin.
    custom_plugin: CustomPlugin,

    pub const json_field_names = .{
        .custom_plugin = "customPlugin",
    };
};
