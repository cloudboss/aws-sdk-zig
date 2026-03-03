/// The domain to associate with an WorkMail organization.
///
/// When you configure a domain hosted in Amazon Route 53 (Route 53), all
/// recommended DNS records are added to the organization when you create it.
/// For more information, see [Adding a
/// domain](https://docs.aws.amazon.com/workmail/latest/adminguide/add_domain.html) in the *WorkMail Administrator Guide*.
pub const Domain = struct {
    /// The fully qualified domain name.
    domain_name: []const u8,

    /// The hosted zone ID for a domain hosted in Route 53. Required when
    /// configuring a domain hosted in Route 53.
    hosted_zone_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .hosted_zone_id = "HostedZoneId",
    };
};
