const ServiceConnectClientAlias = @import("service_connect_client_alias.zig").ServiceConnectClientAlias;
const TimeoutConfiguration = @import("timeout_configuration.zig").TimeoutConfiguration;
const ServiceConnectTlsConfiguration = @import("service_connect_tls_configuration.zig").ServiceConnectTlsConfiguration;

/// The Service Connect service object configuration. For more information, see
/// [Service
/// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const ServiceConnectService = struct {
    /// The list of client aliases for this Service Connect service. You use these
    /// to assign names that can be used by client applications. The maximum number
    /// of client aliases that you can have in this list is 1.
    ///
    /// Each alias ("endpoint") is a fully-qualified name and port number that other
    /// Amazon ECS tasks ("clients") can use to connect to this service.
    ///
    /// Each name and port mapping must be unique within the namespace.
    ///
    /// For each `ServiceConnectService`, you must provide at least one
    /// `clientAlias` with one `port`.
    client_aliases: ?[]const ServiceConnectClientAlias = null,

    /// The `discoveryName` is the name of the new Cloud Map service that Amazon ECS
    /// creates for this Amazon ECS service. This must be unique within the Cloud
    /// Map namespace. The name can contain up to 64 characters. The name can
    /// include lowercase letters, numbers, underscores (_), and hyphens (-). The
    /// name can't start with a hyphen.
    ///
    /// If the `discoveryName` isn't specified, the port mapping name from the task
    /// definition is used in `portName.namespace`.
    discovery_name: ?[]const u8 = null,

    /// The port number for the Service Connect proxy to listen on.
    ///
    /// Use the value of this field to bypass the proxy for traffic on the port
    /// number specified in the named `portMapping` in the task definition of this
    /// application, and then use it in your VPC security groups to allow traffic
    /// into the proxy for this Amazon ECS service.
    ///
    /// In `awsvpc` mode and Fargate, the default value is the container port
    /// number. The container port number is in the `portMapping` in the task
    /// definition. In bridge mode, the default value is the ephemeral port of the
    /// Service Connect proxy.
    ingress_port_override: ?i32 = null,

    /// The `portName` must match the name of one of the `portMappings` from all the
    /// containers in the task definition of this Amazon ECS service.
    port_name: []const u8,

    /// A reference to an object that represents the configured timeouts for Service
    /// Connect.
    timeout: ?TimeoutConfiguration = null,

    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// configuration.
    tls: ?ServiceConnectTlsConfiguration = null,

    pub const json_field_names = .{
        .client_aliases = "clientAliases",
        .discovery_name = "discoveryName",
        .ingress_port_override = "ingressPortOverride",
        .port_name = "portName",
        .timeout = "timeout",
        .tls = "tls",
    };
};
