const Capabilities = @import("capabilities.zig").Capabilities;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ConnectionTypeVariant = @import("connection_type_variant.zig").ConnectionTypeVariant;

/// Brief information about a supported connection type returned by the
/// `ListConnectionTypes` API.
pub const ConnectionTypeBrief = struct {
    /// The supported authentication types, data interface types (compute
    /// environments), and data operations of the connector.
    capabilities: ?Capabilities = null,

    /// A list of categories that this connection type belongs to. Categories help
    /// users filter and find appropriate connection types based on their
    /// use cases.
    categories: ?[]const []const u8 = null,

    /// The name of the connection type.
    connection_type: ?ConnectionType = null,

    /// A list of variants available for this connection type. Different variants
    /// may provide specialized configurations for specific use cases or
    /// implementations of the same general connection type.
    connection_type_variants: ?[]const ConnectionTypeVariant = null,

    /// A description of the connection type.
    description: ?[]const u8 = null,

    /// The human-readable name for the connection type that is displayed in the
    /// Glue console.
    display_name: ?[]const u8 = null,

    /// The URL of the logo associated with a connection type.
    logo_url: ?[]const u8 = null,

    /// The name of the vendor or provider that created or maintains this connection
    /// type.
    vendor: ?[]const u8 = null,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .categories = "Categories",
        .connection_type = "ConnectionType",
        .connection_type_variants = "ConnectionTypeVariants",
        .description = "Description",
        .display_name = "DisplayName",
        .logo_url = "LogoUrl",
        .vendor = "Vendor",
    };
};
