const PrivateDnsPropertiesMutable = @import("private_dns_properties_mutable.zig").PrivateDnsPropertiesMutable;

/// DNS properties for
/// the private DNS namespace.
pub const PrivateDnsNamespaceProperties = struct {
    /// DNS properties for
    /// the private DNS namespace.
    dns_properties: PrivateDnsPropertiesMutable,

    pub const json_field_names = .{
        .dns_properties = "DnsProperties",
    };
};
