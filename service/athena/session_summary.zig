const EngineVersion = @import("engine_version.zig").EngineVersion;
const SessionStatus = @import("session_status.zig").SessionStatus;

/// Contains summary information about a session.
pub const SessionSummary = struct {
    /// The session description.
    description: ?[]const u8,

    /// The engine version used by the session (for example, `PySpark engine version
    /// 3`).
    engine_version: ?EngineVersion,

    /// The notebook version.
    notebook_version: ?[]const u8,

    /// The session ID.
    session_id: ?[]const u8,

    /// Contains information about the session status.
    status: ?SessionStatus,

    pub const json_field_names = .{
        .description = "Description",
        .engine_version = "EngineVersion",
        .notebook_version = "NotebookVersion",
        .session_id = "SessionId",
        .status = "Status",
    };
};
