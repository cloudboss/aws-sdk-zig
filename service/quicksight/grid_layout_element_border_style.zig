const Visibility = @import("visibility.zig").Visibility;

/// The border style configuration of a grid layout element.
pub const GridLayoutElementBorderStyle = struct {
    /// The border color of a grid layout element.
    color: ?[]const u8 = null,

    /// The border visibility of a grid layout element.
    visibility: ?Visibility = null,

    /// The border width of a grid layout element.
    width: ?[]const u8 = null,

    pub const json_field_names = .{
        .color = "Color",
        .visibility = "Visibility",
        .width = "Width",
    };
};
