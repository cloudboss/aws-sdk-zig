const Visibility = @import("visibility.zig").Visibility;

/// The override configuration of the rendering rules of a sheet.
pub const SheetElementConfigurationOverrides = struct {
    /// Determines whether or not the overrides are visible. Choose one of the
    /// following options:
    ///
    /// * `VISIBLE`
    ///
    /// * `HIDDEN`
    visibility: ?Visibility,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
