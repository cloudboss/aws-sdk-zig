const ImageSetConfiguration = @import("image_set_configuration.zig").ImageSetConfiguration;

/// The logo set configuration.
pub const LogoSetConfiguration = struct {
    /// The favicon logo.
    favicon: ?ImageSetConfiguration,

    /// The primary logo.
    primary: ImageSetConfiguration,

    pub const json_field_names = .{
        .favicon = "Favicon",
        .primary = "Primary",
    };
};
