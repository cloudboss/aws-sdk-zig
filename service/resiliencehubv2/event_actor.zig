const ActorType = @import("actor_type.zig").ActorType;

/// Identifies the actor that triggered an event.
pub const EventActor = struct {
    /// The AWS account ID of the actor.
    account_id: ?[]const u8 = null,

    /// The principal ID of the actor.
    principal_id: []const u8,

    /// The type of actor, either USER or SYSTEM.
    type: ActorType,

    /// The user name of the actor.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .principal_id = "principalId",
        .type = "type",
        .user_name = "userName",
    };
};
