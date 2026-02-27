/// Information about active sessions for a Dev Environment.
pub const DevEnvironmentSessionSummary = struct {
    /// The system-generated unique ID of the Dev Environment.
    dev_environment_id: []const u8,

    /// The system-generated unique ID of the Dev Environment session.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    /// The date and time the session started, in coordinated universal time (UTC)
    /// timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    started_time: i64,

    pub const json_field_names = .{
        .dev_environment_id = "devEnvironmentId",
        .id = "id",
        .project_name = "projectName",
        .space_name = "spaceName",
        .started_time = "startedTime",
    };
};
