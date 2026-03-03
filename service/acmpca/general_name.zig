const ASN1Subject = @import("asn1_subject.zig").ASN1Subject;
const EdiPartyName = @import("edi_party_name.zig").EdiPartyName;
const OtherName = @import("other_name.zig").OtherName;

/// Describes an ASN.1 X.400 `GeneralName` as defined in [RFC
/// 5280](https://datatracker.ietf.org/doc/html/rfc5280). Only one of the
/// following naming options should be provided. Providing more than one option
/// results in an `InvalidArgsException` error.
pub const GeneralName = struct {
    directory_name: ?ASN1Subject = null,

    /// Represents `GeneralName` as a DNS name.
    dns_name: ?[]const u8 = null,

    /// Represents `GeneralName` as an `EdiPartyName` object.
    edi_party_name: ?EdiPartyName = null,

    /// Represents `GeneralName` as an IPv4 or IPv6 address.
    ip_address: ?[]const u8 = null,

    /// Represents `GeneralName` using an `OtherName` object.
    other_name: ?OtherName = null,

    /// Represents `GeneralName` as an object identifier (OID).
    registered_id: ?[]const u8 = null,

    /// Represents `GeneralName` as an [RFC
    /// 822](https://datatracker.ietf.org/doc/html/rfc822) email address.
    rfc_822_name: ?[]const u8 = null,

    /// Represents `GeneralName` as a URI.
    uniform_resource_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_name = "DirectoryName",
        .dns_name = "DnsName",
        .edi_party_name = "EdiPartyName",
        .ip_address = "IpAddress",
        .other_name = "OtherName",
        .registered_id = "RegisteredId",
        .rfc_822_name = "Rfc822Name",
        .uniform_resource_identifier = "UniformResourceIdentifier",
    };
};
