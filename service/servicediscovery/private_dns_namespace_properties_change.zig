const PrivateDnsPropertiesMutableChange = @import("private_dns_properties_mutable_change.zig").PrivateDnsPropertiesMutableChange;

/// Updated properties
/// for the private DNS namespace.
pub const PrivateDnsNamespacePropertiesChange = struct {
    /// Updated DNS
    /// properties for the private DNS namespace.
    dns_properties: PrivateDnsPropertiesMutableChange,

    pub const json_field_names = .{
        .dns_properties = "DnsProperties",
    };
};
