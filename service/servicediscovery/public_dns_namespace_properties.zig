const PublicDnsPropertiesMutable = @import("public_dns_properties_mutable.zig").PublicDnsPropertiesMutable;

/// DNS properties for
/// the public DNS namespace.
pub const PublicDnsNamespaceProperties = struct {
    /// DNS properties for
    /// the public DNS namespace.
    dns_properties: PublicDnsPropertiesMutable,

    pub const json_field_names = .{
        .dns_properties = "DnsProperties",
    };
};
