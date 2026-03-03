const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const MinimumHealthyHosts = @import("minimum_healthy_hosts.zig").MinimumHealthyHosts;
const TrafficRoutingConfig = @import("traffic_routing_config.zig").TrafficRoutingConfig;
const ZonalConfig = @import("zonal_config.zig").ZonalConfig;

/// Information about a deployment configuration.
pub const DeploymentConfigInfo = struct {
    /// The destination platform type for the deployment (`Lambda`,
    /// `Server`, or `ECS`).
    compute_platform: ?ComputePlatform = null,

    /// The time at which the deployment configuration was created.
    create_time: ?i64 = null,

    /// The deployment configuration ID.
    deployment_config_id: ?[]const u8 = null,

    /// The deployment configuration name.
    deployment_config_name: ?[]const u8 = null,

    /// Information about the number or percentage of minimum healthy instances.
    minimum_healthy_hosts: ?MinimumHealthyHosts = null,

    /// The configuration that specifies how the deployment traffic is routed. Used
    /// for
    /// deployments with a Lambda or Amazon ECS compute platform
    /// only.
    traffic_routing_config: ?TrafficRoutingConfig = null,

    /// Information about a zonal configuration.
    zonal_config: ?ZonalConfig = null,

    pub const json_field_names = .{
        .compute_platform = "computePlatform",
        .create_time = "createTime",
        .deployment_config_id = "deploymentConfigId",
        .deployment_config_name = "deploymentConfigName",
        .minimum_healthy_hosts = "minimumHealthyHosts",
        .traffic_routing_config = "trafficRoutingConfig",
        .zonal_config = "zonalConfig",
    };
};
