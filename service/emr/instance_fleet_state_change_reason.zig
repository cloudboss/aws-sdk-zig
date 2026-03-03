const InstanceFleetStateChangeReasonCode = @import("instance_fleet_state_change_reason_code.zig").InstanceFleetStateChangeReasonCode;

/// Provides status change reason details for the instance fleet.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceFleetStateChangeReason = struct {
    /// A code corresponding to the reason the state change occurred.
    code: ?InstanceFleetStateChangeReasonCode = null,

    /// An explanatory message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
