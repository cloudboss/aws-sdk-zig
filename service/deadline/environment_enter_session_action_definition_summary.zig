/// Defines the environment a session action enters in.
pub const EnvironmentEnterSessionActionDefinitionSummary = struct {
    /// The environment ID.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};
