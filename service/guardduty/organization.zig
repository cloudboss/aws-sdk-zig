/// Contains information about the ISP organization of the remote IP address.
pub const Organization = struct {
    /// The Autonomous System Number (ASN) of the internet provider of the remote IP
    /// address.
    asn: ?[]const u8,

    /// The organization that registered this ASN.
    asn_org: ?[]const u8,

    /// The ISP information for the internet provider.
    isp: ?[]const u8,

    /// The name of the internet provider.
    org: ?[]const u8,

    pub const json_field_names = .{
        .asn = "Asn",
        .asn_org = "AsnOrg",
        .isp = "Isp",
        .org = "Org",
    };
};
