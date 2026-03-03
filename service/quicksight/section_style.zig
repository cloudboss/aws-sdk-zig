const Spacing = @import("spacing.zig").Spacing;

/// The options that style a section.
pub const SectionStyle = struct {
    /// The height of a section.
    ///
    /// Heights can only be defined for header and footer sections. The default
    /// height margin is 0.5 inches.
    height: ?[]const u8 = null,

    /// The spacing between section content and its top, bottom, left, and right
    /// edges.
    ///
    /// There is no padding by default.
    padding: ?Spacing = null,

    pub const json_field_names = .{
        .height = "Height",
        .padding = "Padding",
    };
};
