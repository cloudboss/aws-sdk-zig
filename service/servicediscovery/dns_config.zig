const DnsRecord = @import("dns_record.zig").DnsRecord;
const RoutingPolicy = @import("routing_policy.zig").RoutingPolicy;

/// A complex type that contains information about the Amazon Route 53 DNS
/// records that you want
/// Cloud Map to create when you register an instance.
pub const DnsConfig = struct {
    /// An array that contains one `DnsRecord` object for each Route 53 DNS record
    /// that you
    /// want Cloud Map to create when you register an instance.
    ///
    /// The record type of a service specified in a `DnsRecord` object can't be
    /// updated.
    /// To change a record type, you need to delete the service and recreate it with
    /// a new
    /// `DnsConfig`.
    dns_records: []const DnsRecord,

    /// *Use
    /// NamespaceId in
    /// [Service](https://docs.aws.amazon.com/cloud-map/latest/api/API_Service.html)
    /// instead.*
    ///
    /// The ID of the namespace to use for DNS configuration.
    namespace_id: ?[]const u8 = null,

    /// The routing policy that you want to apply to all Route 53 DNS records that
    /// Cloud Map creates
    /// when you register an instance and specify this service.
    ///
    /// If you want to use this service to register instances that create alias
    /// records, specify
    /// `WEIGHTED` for the routing policy.
    ///
    /// You can specify the following values:
    ///
    /// **MULTIVALUE**
    ///
    /// If you define a health check for the service and the health check is
    /// healthy, Route 53
    /// returns the applicable value for up to eight instances.
    ///
    /// For example, suppose that the service includes configurations for one `A`
    /// record and a health check. You use the service to register 10 instances.
    /// Route 53 responds to DNS
    /// queries with IP addresses for up to eight healthy instances. If fewer than
    /// eight instances are
    /// healthy, Route 53 responds to every DNS query with the IP addresses for all
    /// of the healthy
    /// instances.
    ///
    /// If you don't define a health check for the service, Route 53 assumes that
    /// all instances are
    /// healthy and returns the values for up to eight instances.
    ///
    /// For more information about the multivalue routing policy, see [Multivalue
    /// Answer
    /// Routing](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-multivalue) in the *Route 53 Developer Guide*.
    ///
    /// **WEIGHTED**
    ///
    /// Route 53 returns the applicable value from one randomly selected instance
    /// from among the
    /// instances that you registered using the same service. Currently, all records
    /// have the same
    /// weight, so you can't route more or less traffic to any instances.
    ///
    /// For example, suppose that the service includes configurations for one `A`
    /// record and a health check. You use the service to register 10 instances.
    /// Route 53 responds to DNS
    /// queries with the IP address for one randomly selected instance from among
    /// the healthy
    /// instances. If no instances are healthy, Route 53 responds to DNS queries as
    /// if all of the
    /// instances were healthy.
    ///
    /// If you don't define a health check for the service, Route 53 assumes that
    /// all instances are
    /// healthy and returns the applicable value for one randomly selected instance.
    ///
    /// For more information about the weighted routing policy, see [Weighted
    /// Routing](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-weighted) in the *Route 53 Developer Guide*.
    routing_policy: ?RoutingPolicy = null,

    pub const json_field_names = .{
        .dns_records = "DnsRecords",
        .namespace_id = "NamespaceId",
        .routing_policy = "RoutingPolicy",
    };
};
