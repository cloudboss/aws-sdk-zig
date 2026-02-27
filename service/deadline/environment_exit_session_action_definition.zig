/// Defines the environment a session action exits from.
pub const EnvironmentExitSessionActionDefinition = struct {
    /// The environment ID.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};
