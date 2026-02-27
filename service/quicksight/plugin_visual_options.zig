const PluginVisualProperty = @import("plugin_visual_property.zig").PluginVisualProperty;

/// The options and persisted properties for the plugin visual.
pub const PluginVisualOptions = struct {
    /// The persisted properties and their values.
    visual_properties: ?[]const PluginVisualProperty,

    pub const json_field_names = .{
        .visual_properties = "VisualProperties",
    };
};
