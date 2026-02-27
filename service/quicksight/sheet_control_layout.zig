const SheetControlLayoutConfiguration = @import("sheet_control_layout_configuration.zig").SheetControlLayoutConfiguration;

/// A grid layout to define the placement of sheet control.
pub const SheetControlLayout = struct {
    /// The configuration that determines the elements and canvas size options of
    /// sheet control.
    configuration: SheetControlLayoutConfiguration,

    pub const json_field_names = .{
        .configuration = "Configuration",
    };
};
