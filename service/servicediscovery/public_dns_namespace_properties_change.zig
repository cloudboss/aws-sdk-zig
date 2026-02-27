const PublicDnsPropertiesMutableChange = @import("public_dns_properties_mutable_change.zig").PublicDnsPropertiesMutableChange;

/// Updated properties
/// for the public DNS namespace.
pub const PublicDnsNamespacePropertiesChange = struct {
    /// Updated DNS
    /// properties for the hosted zone for the public DNS namespace.
    dns_properties: PublicDnsPropertiesMutableChange,

    pub const json_field_names = .{
        .dns_properties = "DnsProperties",
    };
};
