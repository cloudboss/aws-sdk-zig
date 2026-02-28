const PluginTypeCategory = @import("plugin_type_category.zig").PluginTypeCategory;
const PluginType = @import("plugin_type.zig").PluginType;

/// Summary metadata information for a Amazon Q Business plugin.
pub const PluginTypeMetadataSummary = struct {
    /// The category of the plugin type.
    category: ?PluginTypeCategory,

    /// The description assigned by Amazon Q Business to a plugin. You can't modify
    /// this value.
    description: ?[]const u8,

    /// The type of the plugin.
    @"type": ?PluginType,

    pub const json_field_names = .{
        .category = "category",
        .description = "description",
        .@"type" = "type",
    };
};
