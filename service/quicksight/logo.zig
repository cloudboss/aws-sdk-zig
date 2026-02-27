const LogoSet = @import("logo_set.zig").LogoSet;

/// The logo configuration.
pub const Logo = struct {
    /// The alt text for the logo.
    alt_text: []const u8,

    /// A set of configured logos.
    logo_set: LogoSet,

    pub const json_field_names = .{
        .alt_text = "AltText",
        .logo_set = "LogoSet",
    };
};
