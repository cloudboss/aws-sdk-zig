const Session = @import("session.zig").Session;

pub const GetSessionResponse = struct {
    /// The output displays information about the session.
    session: Session,

    pub const json_field_names = .{
        .session = "session",
    };
};
