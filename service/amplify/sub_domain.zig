const SubDomainSetting = @import("sub_domain_setting.zig").SubDomainSetting;

/// The subdomain for the domain association.
pub const SubDomain = struct {
    /// The DNS record for the subdomain.
    dns_record: []const u8,

    /// Describes the settings for the subdomain.
    sub_domain_setting: SubDomainSetting,

    /// The verified status of the subdomain
    verified: bool,

    pub const json_field_names = .{
        .dns_record = "dnsRecord",
        .sub_domain_setting = "subDomainSetting",
        .verified = "verified",
    };
};
