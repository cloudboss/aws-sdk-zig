const LogoSetConfiguration = @import("logo_set_configuration.zig").LogoSetConfiguration;

/// The logo configuration.
pub const LogoConfiguration = struct {
    /// The alt text for the logo.
    alt_text: []const u8,

    /// A set of configured logos.
    logo_set: LogoSetConfiguration,

    pub const json_field_names = .{
        .alt_text = "AltText",
        .logo_set = "LogoSet",
    };
};
