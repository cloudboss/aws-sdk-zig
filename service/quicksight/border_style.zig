/// The display options for tile borders for visuals.
pub const BorderStyle = struct {
    /// The option to add color for tile borders for visuals.
    color: ?[]const u8 = null,

    /// The option to enable display of borders for visuals.
    show: ?bool = null,

    /// The option to set the width of tile borders for visuals.
    width: ?[]const u8 = null,

    pub const json_field_names = .{
        .color = "Color",
        .show = "Show",
        .width = "Width",
    };
};
