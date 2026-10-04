const AuthType = @import("auth_type.zig").AuthType;
const AutoDeploymentMode = @import("auto_deployment_mode.zig").AutoDeploymentMode;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const RevisionWeight = @import("revision_weight.zig").RevisionWeight;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const EndpointState = @import("endpoint_state.zig").EndpointState;
const ThrottleConfig = @import("throttle_config.zig").ThrottleConfig;
const EndpointUpdateStatus = @import("endpoint_update_status.zig").EndpointUpdateStatus;

/// A summary of a web function endpoint.
pub const FunctionEndpointSummary = struct {
    /// The authorization type for the endpoint.
    auth_type: AuthType,

    /// The auto-deployment mode for the endpoint.
    auto_deployment_mode: AutoDeploymentMode,

    /// The date and time the endpoint was created.
    created_at: i64,

    /// A description of the endpoint.
    description: ?[]const u8 = null,

    /// The domain name of the endpoint.
    domain_name: []const u8,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The name of the endpoint.
    endpoint_name: []const u8,

    /// The type of the endpoint.
    endpoint_type: EndpointType,

    /// The list of Regions for the endpoint.
    regions: []const []const u8,

    /// The revision weights for the endpoint.
    revision_weights: []const RevisionWeight,

    /// The scaling configuration for the endpoint. This field is absent if the
    /// endpoint has no scaling configuration.
    scaling_config: ?ScalingConfig = null,

    /// The current state of the endpoint.
    state: EndpointState,

    /// The reason for the current state of the endpoint.
    state_reason: []const u8,

    /// The throttling configuration for the endpoint. This field is absent if the
    /// endpoint has no throttling configuration.
    throttle_config: ?ThrottleConfig = null,

    /// The date and time the endpoint was last updated.
    updated_at: i64,

    /// The status of the most recent update to the endpoint.
    update_status: ?EndpointUpdateStatus = null,

    /// The reason for the current update status of the endpoint.
    update_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .auto_deployment_mode = "autoDeploymentMode",
        .created_at = "createdAt",
        .description = "description",
        .domain_name = "domainName",
        .endpoint_arn = "endpointArn",
        .endpoint_name = "endpointName",
        .endpoint_type = "endpointType",
        .regions = "regions",
        .revision_weights = "revisionWeights",
        .scaling_config = "scalingConfig",
        .state = "state",
        .state_reason = "stateReason",
        .throttle_config = "throttleConfig",
        .updated_at = "updatedAt",
        .update_status = "updateStatus",
        .update_status_reason = "updateStatusReason",
    };
};
