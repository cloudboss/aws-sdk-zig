const ServiceConnectTestTrafficHeaderMatchRules = @import("service_connect_test_traffic_header_match_rules.zig").ServiceConnectTestTrafficHeaderMatchRules;

/// The HTTP header rules used to identify and route test traffic during Amazon
/// ECS blue/green
/// deployments. These rules specify which HTTP headers to examine and what
/// values to match for
/// routing decisions.
///
/// For more information, see [Service Connect for Amazon ECS blue/green
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect-blue-green.html) in the *
/// Amazon Elastic Container Service Developer Guide*.
pub const ServiceConnectTestTrafficHeaderRules = struct {
    /// The name of the HTTP header to examine for test traffic routing. Common
    /// examples include custom headers like `X-Test-Version` or `X-Canary-Request`
    /// that can be used to identify test traffic.
    name: []const u8,

    /// The header value matching configuration that determines how the HTTP header
    /// value is evaluated for test traffic routing decisions.
    value: ?ServiceConnectTestTrafficHeaderMatchRules = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
