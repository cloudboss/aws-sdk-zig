const ServiceConnectAccessLogConfiguration = @import("service_connect_access_log_configuration.zig").ServiceConnectAccessLogConfiguration;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const ServiceConnectService = @import("service_connect_service.zig").ServiceConnectService;

/// The Service Connect configuration of your Amazon ECS service. The
/// configuration for
/// this service to discover and connect to services, and be discovered by, and
/// connected
/// from, other services within a namespace.
///
/// Tasks that run in a namespace can use short names to connect to services in
/// the
/// namespace. Tasks can connect to services across all of the clusters in the
/// namespace.
/// Tasks connect through a managed proxy container that collects logs and
/// metrics for
/// increased visibility. Only the tasks that Amazon ECS services create are
/// supported with
/// Service Connect. For more information, see [Service
/// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html)
/// in the *Amazon Elastic Container Service Developer Guide*.
pub const ServiceConnectConfiguration = struct {
    /// The configuration for Service Connect access logging. Access logs capture
    /// detailed
    /// information about requests made to your service, including request patterns,
    /// response
    /// codes, and timing data. They can be useful for debugging connectivity
    /// issues, monitoring
    /// service performance, and auditing service-to-service communication for
    /// security and
    /// compliance purposes.
    ///
    /// To enable access logs, you must also specify a `logConfiguration` in the
    /// `serviceConnectConfiguration`.
    access_log_configuration: ?ServiceConnectAccessLogConfiguration = null,

    /// Specifies whether to use Service Connect with this service.
    enabled: bool = false,

    log_configuration: ?LogConfiguration = null,

    /// The namespace name or full Amazon Resource Name (ARN) of the Cloud Map
    /// namespace for use
    /// with Service Connect. The namespace must be in the same Amazon Web Services
    /// Region as the
    /// Amazon ECS service and cluster. The type of namespace doesn't affect Service
    /// Connect.
    /// For more information about Cloud Map, see [Working with
    /// Services](https://docs.aws.amazon.com/cloud-map/latest/dg/working-with-services.html)
    /// in the *Cloud Map Developer Guide*.
    namespace: ?[]const u8 = null,

    /// The list of Service Connect service objects. These are names and aliases
    /// (also known
    /// as endpoints) that are used by other Amazon ECS services to connect to this
    /// service.
    ///
    /// This field is not required for a "client" Amazon ECS service that's a member
    /// of a
    /// namespace only to connect to other services within the namespace. An example
    /// of this
    /// would be a frontend application that accepts incoming requests from either a
    /// load
    /// balancer that's attached to the service or by other means.
    ///
    /// An object selects a port from the task definition, assigns a name for the
    /// Cloud Map
    /// service, and a list of aliases (endpoints) and ports for client applications
    /// to refer to
    /// this service.
    services: ?[]const ServiceConnectService = null,

    pub const json_field_names = .{
        .access_log_configuration = "accessLogConfiguration",
        .enabled = "enabled",
        .log_configuration = "logConfiguration",
        .namespace = "namespace",
        .services = "services",
    };
};
