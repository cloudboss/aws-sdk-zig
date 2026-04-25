const DistinguishedName = @import("distinguished_name.zig").DistinguishedName;
const OtherName = @import("other_name.zig").OtherName;

/// Describes an ASN.1 X.400 `GeneralName` as defined in [RFC
/// 5280](https://datatracker.ietf.org/doc/html/rfc5280). Only one of the
/// following naming options should be provided.
pub const GeneralName = union(enum) {
    /// Contains information about the certificate subject. The `Subject` field in
    /// the certificate identifies the entity that owns or controls the public key
    /// in the certificate. The entity can be a user, computer, device, or service.
    /// The `Subject` must contain an X.500 distinguished name (DN). A DN is a
    /// sequence of relative distinguished names (RDNs). The RDNs are separated by
    /// commas in the certificate.
    directory_name: ?DistinguishedName,
    /// Represents `GeneralName` as a DNS name.
    dns_name: ?[]const u8,
    /// Represents `GeneralName` as an IPv4 or IPv6 address.
    ip_address: ?[]const u8,
    /// Represents `GeneralName` using an `OtherName` object.
    other_name: ?OtherName,
    /// Represents `GeneralName` as an object identifier (OID).
    registered_id: ?[]const u8,
    /// Represents `GeneralName` as an [RFC
    /// 822](https://datatracker.ietf.org/doc/html/rfc822) email address.
    rfc_822_name: ?[]const u8,
    /// Represents `GeneralName` as a URI.
    uniform_resource_identifier: ?[]const u8,

    pub const json_field_names = .{
        .directory_name = "DirectoryName",
        .dns_name = "DnsName",
        .ip_address = "IpAddress",
        .other_name = "OtherName",
        .registered_id = "RegisteredId",
        .rfc_822_name = "Rfc822Name",
        .uniform_resource_identifier = "UniformResourceIdentifier",
    };
};
