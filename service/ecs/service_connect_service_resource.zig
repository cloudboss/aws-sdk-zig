/// The Service Connect resource. Each configuration maps a discovery name to a
/// Cloud Map
/// service name. The data is stored in Cloud Map as part of the Service Connect
/// configuration for each discovery name of this Amazon ECS service.
///
/// A task can resolve the `dnsName` for each of the `clientAliases`
/// of a service. However a task can't resolve the discovery names. If you want
/// to connect
/// to a service, refer to the `ServiceConnectConfiguration` of that service for
/// the list of `clientAliases` that you can use.
pub const ServiceConnectServiceResource = struct {
    /// The Amazon Resource Name (ARN) for the service in Cloud Map that matches the
    /// discovery name for this Service Connect resource. You can use this ARN in
    /// other
    /// integrations with Cloud
    /// Map. However, Service Connect can't ensure connectivity outside of Amazon
    /// ECS.
    discovery_arn: ?[]const u8,

    /// The discovery name of this Service Connect resource.
    ///
    /// The `discoveryName` is the name of the new Cloud Map service that Amazon ECS
    /// creates for this Amazon ECS service. This must be unique within the Cloud
    /// Map namespace. The
    /// name can contain up to 64 characters. The name can include lowercase
    /// letters, numbers,
    /// underscores (_), and hyphens (-). The name can't start with a hyphen.
    ///
    /// If the `discoveryName` isn't specified, the port mapping name from the task
    /// definition is used in `portName.namespace`.
    discovery_name: ?[]const u8,

    pub const json_field_names = .{
        .discovery_arn = "discoveryArn",
        .discovery_name = "discoveryName",
    };
};
