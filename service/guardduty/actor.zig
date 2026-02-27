const ActorProcess = @import("actor_process.zig").ActorProcess;
const Session = @import("session.zig").Session;
const User = @import("user.zig").User;

/// Information about the actors involved in an attack sequence.
pub const Actor = struct {
    /// ID of the threat actor.
    id: []const u8,

    /// Contains information about the process associated with the threat actor.
    /// This includes details such as process name, path, execution time, and
    /// unique identifiers that help track the actor's activities within the system.
    process: ?ActorProcess,

    /// Contains information about the user session where the activity initiated.
    session: ?Session,

    /// Contains information about the user credentials used by the threat actor.
    user: ?User,

    pub const json_field_names = .{
        .id = "Id",
        .process = "Process",
        .session = "Session",
        .user = "User",
    };
};
