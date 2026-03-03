const PluginVisualFieldWell = @import("plugin_visual_field_well.zig").PluginVisualFieldWell;
const PluginVisualSortConfiguration = @import("plugin_visual_sort_configuration.zig").PluginVisualSortConfiguration;
const PluginVisualOptions = @import("plugin_visual_options.zig").PluginVisualOptions;

/// The plugin visual configuration. This includes the field wells, sorting
/// options, and persisted options of the plugin visual.
pub const PluginVisualConfiguration = struct {
    /// The field wells configuration of the plugin visual.
    field_wells: ?[]const PluginVisualFieldWell = null,

    /// The sort configuration of the plugin visual.
    sort_configuration: ?PluginVisualSortConfiguration = null,

    /// The persisted properties of the plugin visual.
    visual_options: ?PluginVisualOptions = null,

    pub const json_field_names = .{
        .field_wells = "FieldWells",
        .sort_configuration = "SortConfiguration",
        .visual_options = "VisualOptions",
    };
};
