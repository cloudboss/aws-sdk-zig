const SheetElementConfigurationOverrides = @import("sheet_element_configuration_overrides.zig").SheetElementConfigurationOverrides;

/// The rendering rules of a sheet that uses a free-form layout.
pub const SheetElementRenderingRule = struct {
    /// The override configuration of the rendering rules of a sheet.
    configuration_overrides: SheetElementConfigurationOverrides,

    /// The expression of the rendering rules of a sheet.
    expression: []const u8,

    pub const json_field_names = .{
        .configuration_overrides = "ConfigurationOverrides",
        .expression = "Expression",
    };
};
