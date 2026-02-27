const GridConfiguration = @import("grid_configuration.zig").GridConfiguration;
const PipConfiguration = @import("pip_configuration.zig").PipConfiguration;

/// Configuration information of supported layouts for server-side composition.
pub const LayoutConfiguration = struct {
    /// Configuration related to grid layout. Default: Grid layout.
    grid: ?GridConfiguration,

    /// Configuration related to PiP layout.
    pip: ?PipConfiguration,

    pub const json_field_names = .{
        .grid = "grid",
        .pip = "pip",
    };
};
