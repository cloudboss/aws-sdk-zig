/// A summary of the environment details for which a session action to exits.
pub const EnvironmentExitSessionActionDefinitionSummary = struct {
    /// The environment ID.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};
