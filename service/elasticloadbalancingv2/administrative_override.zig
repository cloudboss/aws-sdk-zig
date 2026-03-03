const TargetAdministrativeOverrideReasonEnum = @import("target_administrative_override_reason_enum.zig").TargetAdministrativeOverrideReasonEnum;
const TargetAdministrativeOverrideStateEnum = @import("target_administrative_override_state_enum.zig").TargetAdministrativeOverrideStateEnum;

/// Information about the override status applied to a target.
pub const AdministrativeOverride = struct {
    /// A description of the override state that provides additional details.
    description: ?[]const u8 = null,

    /// The reason code for the state.
    reason: ?TargetAdministrativeOverrideReasonEnum = null,

    /// The state of the override.
    state: ?TargetAdministrativeOverrideStateEnum = null,
};
