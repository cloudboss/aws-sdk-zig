/// The background configuration for sheets.
pub const SheetBackgroundStyle = struct {
    /// The solid color background option for sheets.
    color: ?[]const u8,

    /// The gradient background option for sheets.
    gradient: ?[]const u8,

    pub const json_field_names = .{
        .color = "Color",
        .gradient = "Gradient",
    };
};
