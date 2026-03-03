const NavbarStyle = @import("navbar_style.zig").NavbarStyle;

/// The element style.
pub const BrandElementStyle = struct {
    /// The navigation bar style.
    navbar_style: ?NavbarStyle = null,

    pub const json_field_names = .{
        .navbar_style = "NavbarStyle",
    };
};
