/// Contains the notebook session ID and notebook session creation time.
pub const NotebookSessionSummary = struct {
    /// The time when the notebook session was created.
    creation_time: ?i64,

    /// The notebook session ID.
    session_id: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .session_id = "SessionId",
    };
};
