const AuthType = @import("auth_type.zig").AuthType;
const AutoDeploymentMode = @import("auto_deployment_mode.zig").AutoDeploymentMode;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const ThrottleConfig = @import("throttle_config.zig").ThrottleConfig;

/// The configuration for a web function endpoint.
pub const EndpointConfig = struct {
    /// The authorization type for the endpoint.
    auth_type: AuthType,

    /// The auto-deployment mode for the endpoint. If you don't specify a value, the
    /// default is `Disabled`, and this default is returned in the response.
    auto_deployment_mode: ?AutoDeploymentMode = null,

    /// A description of the endpoint.
    description: ?[]const u8 = null,

    /// The name of the endpoint. The name can contain letters, numbers, hyphens
    /// (-), and underscores (_), and can't begin or end with a hyphen or an
    /// underscore. The length constraint applies only to the full ARN. If you
    /// specify only the endpoint name, it is limited to 64 characters in length.
    endpoint_name: []const u8,

    /// The type of endpoint. Determines how traffic is served and routed across
    /// Regions.
    endpoint_type: EndpointType,

    /// The list of Regions for the endpoint. Required when the endpoint type is
    /// `MultiRegion` or `PerRegion`: specify at least one Region other than the
    /// Region where you create the endpoint (the home Region). The home Region is
    /// added automatically if you don't include it; specifying only the home Region
    /// isn't allowed. When the endpoint type is `HomeRegion`, omit this field or
    /// specify only the home Region.
    regions: ?[]const []const u8 = null,

    /// The scaling configuration for the endpoint.
    scaling_config: ?ScalingConfig = null,

    /// The throttling configuration for the endpoint.
    throttle_config: ?ThrottleConfig = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .auto_deployment_mode = "autoDeploymentMode",
        .description = "description",
        .endpoint_name = "endpointName",
        .endpoint_type = "endpointType",
        .regions = "regions",
        .scaling_config = "scalingConfig",
        .throttle_config = "throttleConfig",
    };
};
