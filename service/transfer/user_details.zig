/// Specifies the user name, server ID, and session ID for a workflow.
pub const UserDetails = struct {
    /// The system-assigned unique identifier for a Transfer server instance.
    server_id: []const u8,

    /// The system-assigned unique identifier for a session that corresponds to the
    /// workflow.
    session_id: ?[]const u8,

    /// A unique string that identifies a Transfer Family user associated with a
    /// server.
    user_name: []const u8,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .session_id = "SessionId",
        .user_name = "UserName",
    };
};
