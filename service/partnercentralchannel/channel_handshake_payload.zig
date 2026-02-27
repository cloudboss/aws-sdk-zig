const RevokeServicePeriodPayload = @import("revoke_service_period_payload.zig").RevokeServicePeriodPayload;
const StartServicePeriodPayload = @import("start_service_period_payload.zig").StartServicePeriodPayload;

/// Contains the payload data for different types of channel handshakes.
pub const ChannelHandshakePayload = union(enum) {
    /// Payload for revoking a service period handshake.
    revoke_service_period_payload: ?RevokeServicePeriodPayload,
    /// Payload for starting a service period handshake.
    start_service_period_payload: ?StartServicePeriodPayload,

    pub const json_field_names = .{
        .revoke_service_period_payload = "revokeServicePeriodPayload",
        .start_service_period_payload = "startServicePeriodPayload",
    };
};
