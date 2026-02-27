const ApplicationTheme = @import("application_theme.zig").ApplicationTheme;
const LogoConfiguration = @import("logo_configuration.zig").LogoConfiguration;

/// The definition of the brand.
pub const BrandDefinition = struct {
    /// The application theme of the brand.
    application_theme: ?ApplicationTheme,

    /// The name of the brand.
    brand_name: []const u8,

    /// The description of the brand.
    description: ?[]const u8,

    /// The logo configuration of the brand.
    logo_configuration: ?LogoConfiguration,

    pub const json_field_names = .{
        .application_theme = "ApplicationTheme",
        .brand_name = "BrandName",
        .description = "Description",
        .logo_configuration = "LogoConfiguration",
    };
};
