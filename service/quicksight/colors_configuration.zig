const CustomColor = @import("custom_color.zig").CustomColor;

/// The color configurations for a column.
pub const ColorsConfiguration = struct {
    /// A list of up to 50 custom colors.
    custom_colors: ?[]const CustomColor,

    pub const json_field_names = .{
        .custom_colors = "CustomColors",
    };
};
