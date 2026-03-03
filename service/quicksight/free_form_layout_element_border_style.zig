const Visibility = @import("visibility.zig").Visibility;

/// The background style configuration of a free-form layout element.
pub const FreeFormLayoutElementBorderStyle = struct {
    /// The border color of a free-form layout element.
    color: ?[]const u8 = null,

    /// The border visibility of a free-form layout element.
    visibility: ?Visibility = null,

    /// The border width of a free-form layout element.
    width: ?[]const u8 = null,

    pub const json_field_names = .{
        .color = "Color",
        .visibility = "Visibility",
        .width = "Width",
    };
};
