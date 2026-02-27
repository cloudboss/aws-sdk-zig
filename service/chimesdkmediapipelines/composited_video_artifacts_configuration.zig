const GridViewConfiguration = @import("grid_view_configuration.zig").GridViewConfiguration;
const LayoutOption = @import("layout_option.zig").LayoutOption;
const ResolutionOption = @import("resolution_option.zig").ResolutionOption;

/// Specifies the configuration for compositing video artifacts.
pub const CompositedVideoArtifactsConfiguration = struct {
    /// The `GridView` configuration setting.
    grid_view_configuration: GridViewConfiguration,

    /// The layout setting, such as `GridView` in the configuration object.
    layout: ?LayoutOption,

    /// The video resolution setting in the configuration object. Default: HD at
    /// 1280 x 720. FHD resolution: 1920 x 1080.
    resolution: ?ResolutionOption,

    pub const json_field_names = .{
        .grid_view_configuration = "GridViewConfiguration",
        .layout = "Layout",
        .resolution = "Resolution",
    };
};
