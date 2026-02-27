const PrivateDnsNamespacePropertiesChange = @import("private_dns_namespace_properties_change.zig").PrivateDnsNamespacePropertiesChange;

/// Updated properties
/// for the private DNS namespace.
pub const PrivateDnsNamespaceChange = struct {
    /// An updated
    /// description for the private DNS namespace.
    description: ?[]const u8,

    /// Properties to be
    /// updated in the private DNS namespace.
    properties: ?PrivateDnsNamespacePropertiesChange,

    pub const json_field_names = .{
        .description = "Description",
        .properties = "Properties",
    };
};
