const DnsConfig = @import("dns_config.zig").DnsConfig;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const HealthCheckCustomConfig = @import("health_check_custom_config.zig").HealthCheckCustomConfig;
const ServiceType = @import("service_type.zig").ServiceType;

/// A complex type that contains information about the specified service.
pub const Service = struct {
    /// The Amazon Resource Name (ARN) that Cloud Map assigns to the service when
    /// you create it.
    arn: ?[]const u8,

    /// The date and time that the service was created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreateDate` is accurate to milliseconds. For
    /// example, the
    /// value `1516925490.087` represents Friday, January 26, 2018 12:11:30.087 AM.
    create_date: ?i64,

    /// The ID of the Amazon Web Services account that created the service. If this
    /// isn't your account ID, it is
    /// the ID of account of the namespace owner or of another account with which
    /// the namespace has been
    /// shared. For more information about shared namespaces, see [Cross-account
    /// Cloud Map
    /// namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    created_by_account: ?[]const u8,

    /// A unique string that identifies the request and that allows failed requests
    /// to be retried
    /// without the risk of running the operation twice. `CreatorRequestId` can be
    /// any unique
    /// string (for example, a date/timestamp).
    creator_request_id: ?[]const u8,

    /// The description of the service.
    description: ?[]const u8,

    /// A complex type that contains information about the Route 53 DNS records that
    /// you want
    /// Cloud Map to create when you register an instance.
    ///
    /// The record types of a service can only be changed by deleting the service
    /// and recreating it
    /// with a new `Dnsconfig`.
    dns_config: ?DnsConfig,

    /// *Public DNS and HTTP namespaces only.* A complex type that contains
    /// settings for an optional health check. If you specify settings for a health
    /// check, Cloud Map
    /// associates the health check with the records that you specify in
    /// `DnsConfig`.
    ///
    /// For information about the charges for health checks, see [Amazon Route 53
    /// Pricing](http://aws.amazon.com/route53/pricing/).
    health_check_config: ?HealthCheckConfig,

    /// A complex type that contains information about an optional custom health
    /// check.
    ///
    /// If you specify a health check configuration, you can specify either
    /// `HealthCheckCustomConfig` or `HealthCheckConfig` but not both.
    health_check_custom_config: ?HealthCheckCustomConfig,

    /// The ID that Cloud Map assigned to the service when you created it.
    id: ?[]const u8,

    /// The number of instances that are currently associated with the service.
    /// Instances that were
    /// previously associated with the service but that are deleted aren't included
    /// in the count. The
    /// count might not reflect pending registrations and deregistrations.
    instance_count: ?i32,

    /// The name of the service.
    name: ?[]const u8,

    /// The ID of the namespace that was used to create the service.
    namespace_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that created the namespace with
    /// which the service is associated.
    /// If this isn't your account ID, it is the ID of the account that shared the
    /// namespace with your
    /// account. For more information about shared namespaces, see [Cross-account
    /// Cloud Map
    /// namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    resource_owner: ?[]const u8,

    /// Describes the systems that can be used to discover the service instances.
    ///
    /// **DNS_HTTP**
    ///
    /// The service instances can be discovered using either DNS queries or the
    /// `DiscoverInstances` API operation.
    ///
    /// **HTTP**
    ///
    /// The service instances can only be discovered using the `DiscoverInstances`
    /// API
    /// operation.
    ///
    /// **DNS**
    ///
    /// Reserved.
    type: ?ServiceType,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_date = "CreateDate",
        .created_by_account = "CreatedByAccount",
        .creator_request_id = "CreatorRequestId",
        .description = "Description",
        .dns_config = "DnsConfig",
        .health_check_config = "HealthCheckConfig",
        .health_check_custom_config = "HealthCheckCustomConfig",
        .id = "Id",
        .instance_count = "InstanceCount",
        .name = "Name",
        .namespace_id = "NamespaceId",
        .resource_owner = "ResourceOwner",
        .type = "Type",
    };
};
