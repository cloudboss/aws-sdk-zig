/// The assigned starting environment for a worker during session.
pub const AssignedEnvironmentEnterSessionActionDefinition = struct {
    /// The environment ID of the assigned environment at the start of a session.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};
