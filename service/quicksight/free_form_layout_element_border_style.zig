const Visibility = @import("visibility.zig").Visibility;

/// The background style configuration of a free-form layout element.
pub const FreeFormLayoutElementBorderStyle = struct {
    /// The border color of a free-form layout element.
    color: ?[]const u8,

    /// The border visibility of a free-form layout element.
    visibility: ?Visibility,

    /// The border width of a free-form layout element.
    width: ?[]const u8,

    pub const json_field_names = .{
        .color = "Color",
        .visibility = "Visibility",
        .width = "Width",
    };
};
