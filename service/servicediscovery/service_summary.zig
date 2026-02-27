const DnsConfig = @import("dns_config.zig").DnsConfig;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const HealthCheckCustomConfig = @import("health_check_custom_config.zig").HealthCheckCustomConfig;
const ServiceType = @import("service_type.zig").ServiceType;

/// A complex type that contains information about a specified service.
pub const ServiceSummary = struct {
    /// The Amazon Resource Name (ARN) that Cloud Map assigns to the service when
    /// you create it.
    arn: ?[]const u8,

    /// The date and time that the service was created.
    create_date: ?i64,

    /// The ID of the Amazon Web Services account that created the service. If this
    /// isn't your account ID, it is
    /// the account ID of the namespace owner or of another account with which the
    /// namespace has been
    /// shared. For more information about shared namespaces, see [Cross-account
    /// Cloud Map
    /// namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    created_by_account: ?[]const u8,

    /// The description that you specify when you create the service.
    description: ?[]const u8,

    /// Information about the Route 53 DNS records that you want Cloud Map to create
    /// when you register
    /// an instance.
    dns_config: ?DnsConfig,

    /// *Public DNS and HTTP namespaces only.* Settings for an optional health
    /// check. If you specify settings for a health check, Cloud Map associates the
    /// health check with
    /// the records that you specify in `DnsConfig`.
    health_check_config: ?HealthCheckConfig,

    /// Information about an optional custom health check. A custom health check,
    /// which requires
    /// that you use a third-party health checker to evaluate the health of your
    /// resources, is useful in
    /// the following circumstances:
    ///
    /// * You can't use a health check that's defined by `HealthCheckConfig` because
    ///   the
    /// resource isn't available over the internet. For example, you can use a
    /// custom health check when
    /// the instance is in an Amazon VPC. (To check the health of resources in a
    /// VPC, the health
    /// checker must also be in the VPC.)
    ///
    /// * You want to use a third-party health checker regardless of where your
    ///   resources are
    /// located.
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
        .description = "Description",
        .dns_config = "DnsConfig",
        .health_check_config = "HealthCheckConfig",
        .health_check_custom_config = "HealthCheckCustomConfig",
        .id = "Id",
        .instance_count = "InstanceCount",
        .name = "Name",
        .resource_owner = "ResourceOwner",
        .type = "Type",
    };
};
