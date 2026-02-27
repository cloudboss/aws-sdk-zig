/// Represents a variant of a connection type in Glue. Connection type variants
/// provide specific configurations and behaviors
/// for different implementations of the same general connection type.
pub const ConnectionTypeVariant = struct {
    /// The unique identifier for the connection type variant. This name is used
    /// internally to identify the specific variant of a connection type.
    connection_type_variant_name: ?[]const u8,

    /// A detailed description of the connection type variant, including its
    /// purpose, use cases, and any specific configuration requirements.
    description: ?[]const u8,

    /// The human-readable name for the connection type variant that is displayed in
    /// the Glue console.
    display_name: ?[]const u8,

    /// The URL of the logo associated with a connection type variant.
    logo_url: ?[]const u8,

    pub const json_field_names = .{
        .connection_type_variant_name = "ConnectionTypeVariantName",
        .description = "Description",
        .display_name = "DisplayName",
        .logo_url = "LogoUrl",
    };
};
