const AwsElbLoadBalancerAccessLog = @import("aws_elb_load_balancer_access_log.zig").AwsElbLoadBalancerAccessLog;
const AwsElbLoadBalancerAdditionalAttribute = @import("aws_elb_load_balancer_additional_attribute.zig").AwsElbLoadBalancerAdditionalAttribute;
const AwsElbLoadBalancerConnectionDraining = @import("aws_elb_load_balancer_connection_draining.zig").AwsElbLoadBalancerConnectionDraining;
const AwsElbLoadBalancerConnectionSettings = @import("aws_elb_load_balancer_connection_settings.zig").AwsElbLoadBalancerConnectionSettings;
const AwsElbLoadBalancerCrossZoneLoadBalancing = @import("aws_elb_load_balancer_cross_zone_load_balancing.zig").AwsElbLoadBalancerCrossZoneLoadBalancing;

/// Contains attributes for the load balancer.
pub const AwsElbLoadBalancerAttributes = struct {
    /// Information about the access log configuration for the load balancer.
    ///
    /// If the access log is enabled, the load balancer captures detailed
    /// information about all
    /// requests. It delivers the information to a specified S3 bucket.
    access_log: ?AwsElbLoadBalancerAccessLog,

    /// Any additional attributes for a load balancer.
    additional_attributes: ?[]const AwsElbLoadBalancerAdditionalAttribute,

    /// Information about the connection draining configuration for the load
    /// balancer.
    ///
    /// If connection draining is enabled, the load balancer allows existing
    /// requests to
    /// complete before it shifts traffic away from a deregistered or unhealthy
    /// instance.
    connection_draining: ?AwsElbLoadBalancerConnectionDraining,

    /// Connection settings for the load balancer.
    ///
    /// If an idle timeout is configured, the load balancer allows connections to
    /// remain idle
    /// for the specified duration. When a connection is idle, no data is sent over
    /// the
    /// connection.
    connection_settings: ?AwsElbLoadBalancerConnectionSettings,

    /// Cross-zone load balancing settings for the load balancer.
    ///
    /// If cross-zone load balancing is enabled, the load balancer routes the
    /// request traffic
    /// evenly across all instances regardless of the Availability Zones.
    cross_zone_load_balancing: ?AwsElbLoadBalancerCrossZoneLoadBalancing,

    pub const json_field_names = .{
        .access_log = "AccessLog",
        .additional_attributes = "AdditionalAttributes",
        .connection_draining = "ConnectionDraining",
        .connection_settings = "ConnectionSettings",
        .cross_zone_load_balancing = "CrossZoneLoadBalancing",
    };
};
