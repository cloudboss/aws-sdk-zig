/// Describes the DNS information of a service.
pub const DnsEntry = struct {
    /// The domain name of the service.
    domain_name: ?[]const u8 = null,

    /// The ID of the hosted zone.
    hosted_zone_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .hosted_zone_id = "hostedZoneId",
    };
};
