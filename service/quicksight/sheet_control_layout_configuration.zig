const GridLayoutConfiguration = @import("grid_layout_configuration.zig").GridLayoutConfiguration;

/// The configuration that determines the elements and canvas size options of
/// sheet control.
pub const SheetControlLayoutConfiguration = struct {
    /// The configuration that determines the elements and canvas size options of
    /// sheet control.
    grid_layout: ?GridLayoutConfiguration = null,

    pub const json_field_names = .{
        .grid_layout = "GridLayout",
    };
};
