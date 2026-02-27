const AccessLog = @import("access_log.zig").AccessLog;
const AdditionalAttribute = @import("additional_attribute.zig").AdditionalAttribute;
const ConnectionDraining = @import("connection_draining.zig").ConnectionDraining;
const ConnectionSettings = @import("connection_settings.zig").ConnectionSettings;
const CrossZoneLoadBalancing = @import("cross_zone_load_balancing.zig").CrossZoneLoadBalancing;

/// The attributes for a load balancer.
pub const LoadBalancerAttributes = struct {
    /// If enabled, the load balancer captures detailed information of all requests
    /// and delivers the information to the Amazon S3 bucket that you specify.
    ///
    /// For more information, see [Enable Access
    /// Logs](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-access-logs.html)
    /// in the *Classic Load Balancers Guide*.
    access_log: ?AccessLog,

    /// Any additional attributes.
    additional_attributes: ?[]const AdditionalAttribute,

    /// If enabled, the load balancer allows existing requests to complete before
    /// the load balancer shifts traffic away from a deregistered or unhealthy
    /// instance.
    ///
    /// For more information, see [Configure Connection
    /// Draining](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/config-conn-drain.html)
    /// in the *Classic Load Balancers Guide*.
    connection_draining: ?ConnectionDraining,

    /// If enabled, the load balancer allows the connections to remain idle (no data
    /// is sent over the connection) for the specified duration.
    ///
    /// By default, Elastic Load Balancing maintains a 60-second idle connection
    /// timeout for both front-end and back-end connections of your load balancer.
    /// For more information, see [Configure Idle Connection
    /// Timeout](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/config-idle-timeout.html)
    /// in the *Classic Load Balancers Guide*.
    connection_settings: ?ConnectionSettings,

    /// If enabled, the load balancer routes the request traffic evenly across all
    /// instances regardless of the Availability Zones.
    ///
    /// For more information, see [Configure Cross-Zone Load
    /// Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-disable-crosszone-lb.html)
    /// in the *Classic Load Balancers Guide*.
    cross_zone_load_balancing: ?CrossZoneLoadBalancing,
};
