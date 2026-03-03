const SessionData = @import("session_data.zig").SessionData;

pub const CreateSessionResponse = struct {
    /// The session.
    session: ?SessionData = null,

    pub const json_field_names = .{
        .session = "session",
    };
};
