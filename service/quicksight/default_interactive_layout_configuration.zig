const DefaultFreeFormLayoutConfiguration = @import("default_free_form_layout_configuration.zig").DefaultFreeFormLayoutConfiguration;
const DefaultGridLayoutConfiguration = @import("default_grid_layout_configuration.zig").DefaultGridLayoutConfiguration;

/// The options that determine the default settings for interactive layout
/// configuration.
pub const DefaultInteractiveLayoutConfiguration = struct {
    /// The options that determine the default settings of a free-form layout
    /// configuration.
    free_form: ?DefaultFreeFormLayoutConfiguration,

    /// The options that determine the default settings for a grid layout
    /// configuration.
    grid: ?DefaultGridLayoutConfiguration,

    pub const json_field_names = .{
        .free_form = "FreeForm",
        .grid = "Grid",
    };
};
