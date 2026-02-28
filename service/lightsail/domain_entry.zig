const aws = @import("aws");

/// Describes a domain recordset entry.
pub const DomainEntry = struct {
    /// The ID of the domain recordset entry.
    id: ?[]const u8,

    /// When `true`, specifies whether the domain entry is an alias used by the
    /// Lightsail load balancer, Lightsail container service, Lightsail content
    /// delivery network (CDN) distribution, or another Amazon Web Services
    /// resource. You can include an alias (A type) record in your request, which
    /// points to the DNS
    /// name of a load balancer, container service, CDN distribution, or other
    /// Amazon Web Services
    /// resource and routes traffic to that resource.
    is_alias: ?bool,

    /// The name of the domain.
    name: ?[]const u8,

    /// (Discontinued) The options for the domain entry.
    ///
    /// In releases prior to November 29, 2017, this parameter was not included in
    /// the API
    /// response. It is now discontinued.
    options: ?[]const aws.map.StringMapEntry,

    /// The target IP address (`192.0.2.0`), or AWS name server
    /// (`ns-111.awsdns-22.com.`).
    ///
    /// For Lightsail load balancers, the value looks like
    /// `ab1234c56789c6b86aba6fb203d443bc-123456789.us-east-2.elb.amazonaws.com`.
    /// For
    /// Lightsail distributions, the value looks like
    /// `exampled1182ne.cloudfront.net`.
    /// For Lightsail container services, the value looks like
    /// `container-service-1.example23scljs.us-west-2.cs.amazonlightsail.com`. Be
    /// sure to
    /// also set `isAlias` to `true` when setting up an A record for a
    /// Lightsail load balancer, distribution, or container service.
    target: ?[]const u8,

    /// The type of domain entry, such as address for IPv4 (A), address for IPv6
    /// (AAAA), canonical
    /// name (CNAME), mail exchanger (MX), name server (NS), start of authority
    /// (SOA), service locator
    /// (SRV), or text (TXT).
    ///
    /// The following domain entry types can be used:
    ///
    /// * `A`
    ///
    /// * `AAAA`
    ///
    /// * `CNAME`
    ///
    /// * `MX`
    ///
    /// * `NS`
    ///
    /// * `SOA`
    ///
    /// * `SRV`
    ///
    /// * `TXT`
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .is_alias = "isAlias",
        .name = "name",
        .options = "options",
        .target = "target",
        .@"type" = "type",
    };
};
