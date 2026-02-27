const PublicDnsNamespacePropertiesChange = @import("public_dns_namespace_properties_change.zig").PublicDnsNamespacePropertiesChange;

/// Updated properties
/// for the public DNS namespace.
pub const PublicDnsNamespaceChange = struct {
    /// An updated
    /// description for the public DNS namespace.
    description: ?[]const u8,

    /// Properties to be
    /// updated in the public DNS namespace.
    properties: ?PublicDnsNamespacePropertiesChange,

    pub const json_field_names = .{
        .description = "Description",
        .properties = "Properties",
    };
};
