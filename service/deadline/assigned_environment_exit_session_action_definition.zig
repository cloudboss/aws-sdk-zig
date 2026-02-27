/// The assigned environment when a worker exits a session.
pub const AssignedEnvironmentExitSessionActionDefinition = struct {
    /// The environment ID of the assigned environment when exiting a session.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};
