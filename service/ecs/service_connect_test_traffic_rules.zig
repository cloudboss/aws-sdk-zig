const ServiceConnectTestTrafficHeaderRules = @import("service_connect_test_traffic_header_rules.zig").ServiceConnectTestTrafficHeaderRules;

/// The test traffic routing configuration for Amazon ECS blue/green
/// deployments. This configuration allows you to define rules for routing
/// specific traffic to the new service revision during the deployment process,
/// allowing for safe testing before full production traffic shift.
///
/// For more information, see [Service Connect for Amazon ECS blue/green
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect-blue-green.html) in the * Amazon Elastic Container Service Developer Guide*.
pub const ServiceConnectTestTrafficRules = struct {
    /// The HTTP header-based routing rules that determine which requests should be
    /// routed to the new service version during blue/green deployment testing.
    /// These rules provide fine-grained control over test traffic routing based on
    /// request headers.
    header: ServiceConnectTestTrafficHeaderRules,

    pub const json_field_names = .{
        .header = "header",
    };
};
