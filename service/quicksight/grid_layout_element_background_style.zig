const Visibility = @import("visibility.zig").Visibility;

/// The background style configuration of a grid layout element.
pub const GridLayoutElementBackgroundStyle = struct {
    /// The background color of a grid layout element.
    color: ?[]const u8,

    /// The background visibility of a grid layout element.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .color = "Color",
        .visibility = "Visibility",
    };
};
