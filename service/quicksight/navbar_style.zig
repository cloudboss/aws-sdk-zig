const Palette = @import("palette.zig").Palette;

/// The navigation bar style.
pub const NavbarStyle = struct {
    /// The contextual navigation bar style.
    contextual_navbar: ?Palette = null,

    /// The global navigation bar style.
    global_navbar: ?Palette = null,

    pub const json_field_names = .{
        .contextual_navbar = "ContextualNavbar",
        .global_navbar = "GlobalNavbar",
    };
};
