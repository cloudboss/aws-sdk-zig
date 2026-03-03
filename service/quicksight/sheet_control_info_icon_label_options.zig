const Visibility = @import("visibility.zig").Visibility;

/// A control to display info icons for filters and parameters.
pub const SheetControlInfoIconLabelOptions = struct {
    /// The text content of info icon.
    info_icon_text: ?[]const u8 = null,

    /// The visibility configuration of info icon label options.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .info_icon_text = "InfoIconText",
        .visibility = "Visibility",
    };
};
