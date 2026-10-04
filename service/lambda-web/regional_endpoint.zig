const AuthType = @import("auth_type.zig").AuthType;
const RevisionWeight = @import("revision_weight.zig").RevisionWeight;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const EndpointState = @import("endpoint_state.zig").EndpointState;
const ThrottleConfig = @import("throttle_config.zig").ThrottleConfig;
const EndpointUpdateStatus = @import("endpoint_update_status.zig").EndpointUpdateStatus;

/// Represents the endpoint configuration and state in a specific Region.
pub const RegionalEndpoint = struct {
    /// The authorization type for the regional endpoint.
    auth_type: AuthType,

    /// The domain name of the regional endpoint.
    domain_name: ?[]const u8 = null,

    /// The revision weights for the regional endpoint.
    revision_weights: []const RevisionWeight,

    /// The scaling configuration for the regional endpoint. This field is absent if
    /// the endpoint has no scaling configuration.
    scaling_config: ?ScalingConfig = null,

    /// The current state of the regional endpoint.
    state: EndpointState,

    /// The reason for the current state of the regional endpoint.
    state_reason: []const u8,

    /// The throttling configuration for the regional endpoint. This field is absent
    /// if the endpoint has no throttling configuration.
    throttle_config: ?ThrottleConfig = null,

    /// The status of the most recent update to the regional endpoint.
    update_status: ?EndpointUpdateStatus = null,

    /// The reason for the current update status of the regional endpoint.
    update_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .domain_name = "domainName",
        .revision_weights = "revisionWeights",
        .scaling_config = "scalingConfig",
        .state = "state",
        .state_reason = "stateReason",
        .throttle_config = "throttleConfig",
        .update_status = "updateStatus",
        .update_status_reason = "updateStatusReason",
    };
};
