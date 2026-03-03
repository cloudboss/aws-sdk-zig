const aws = @import("aws");

/// A complex type that contains information about the instances that you
/// registered by using a
/// specified service.
pub const InstanceSummary = struct {
    /// A string map that contains the following information:
    ///
    /// * The attributes that are associated with the instance.
    ///
    /// * For each attribute, the applicable value.
    ///
    /// Supported attribute keys include the following:
    ///
    /// **AWS_ALIAS_DNS_NAME**
    ///
    /// For an alias record that routes traffic to an Elastic Load Balancing load
    /// balancer, the DNS name that's
    /// associated with the load balancer.
    ///
    /// **AWS_EC2_INSTANCE_ID (HTTP namespaces only)**
    ///
    /// The Amazon EC2 instance ID for the instance. When the `AWS_EC2_INSTANCE_ID`
    /// attribute is specified, then the `AWS_INSTANCE_IPV4` attribute contains the
    /// primary
    /// private IPv4 address.
    ///
    /// **AWS_INIT_HEALTH_STATUS**
    ///
    /// If the service configuration includes `HealthCheckCustomConfig`, you can
    /// optionally use `AWS_INIT_HEALTH_STATUS` to specify the initial status of the
    /// custom
    /// health check, `HEALTHY` or `UNHEALTHY`. If you don't specify a value for
    /// `AWS_INIT_HEALTH_STATUS`, the initial status is `HEALTHY`.
    ///
    /// **AWS_INSTANCE_CNAME**
    ///
    /// For a `CNAME` record, the domain name that Route 53 returns in response to
    /// DNS
    /// queries (for example, `example.com`).
    ///
    /// **AWS_INSTANCE_IPV4**
    ///
    /// For an `A` record, the IPv4 address that Route 53 returns in response to DNS
    /// queries (for example, `192.0.2.44`).
    ///
    /// **AWS_INSTANCE_IPV6**
    ///
    /// For an `AAAA` record, the IPv6 address that Route 53 returns in response to
    /// DNS
    /// queries (for example, `2001:0db8:85a3:0000:0000:abcd:0001:2345`).
    ///
    /// **AWS_INSTANCE_PORT**
    ///
    /// For an `SRV` record, the value that Route 53 returns for the port. In
    /// addition,
    /// if the service includes `HealthCheckConfig`, the port on the endpoint that
    /// Route 53
    /// sends requests to.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the Amazon Web Services account that registered the instance. If
    /// this isn't your account ID,
    /// it's the ID of the account that shared the namespace with your account or
    /// the ID of another
    /// account with which the namespace has been shared. For more information about
    /// shared namespaces,
    /// see [Cross-account
    /// Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    created_by_account: ?[]const u8 = null,

    /// The ID for an instance that you created by using a specified service.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .created_by_account = "CreatedByAccount",
        .id = "Id",
    };
};
