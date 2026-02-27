const Visibility = @import("visibility.zig").Visibility;

/// The background style configuration of a free-form layout element.
pub const FreeFormLayoutElementBackgroundStyle = struct {
    /// The background color of a free-form layout element.
    color: ?[]const u8,

    /// The background visibility of a free-form layout element.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .color = "Color",
        .visibility = "Visibility",
    };
};
