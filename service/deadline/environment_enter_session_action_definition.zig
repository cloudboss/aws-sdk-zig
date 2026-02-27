/// The environment ID to use to enter a session action.
pub const EnvironmentEnterSessionActionDefinition = struct {
    /// The environment ID.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};
