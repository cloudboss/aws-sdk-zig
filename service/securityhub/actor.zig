const ActorSession = @import("actor_session.zig").ActorSession;
const ActorUser = @import("actor_user.zig").ActorUser;

/// Information about the threat actor identified in an Amazon GuardDuty
/// Extended Threat Detection attack sequence. GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub
/// CSPM, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const Actor = struct {
    /// The ID of the threat actor.
    id: ?[]const u8 = null,

    /// Contains information about the user session where the activity initiated.
    session: ?ActorSession = null,

    /// Contains information about the user credentials used by the threat actor.
    user: ?ActorUser = null,

    pub const json_field_names = .{
        .id = "Id",
        .session = "Session",
        .user = "User",
    };
};
