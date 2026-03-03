const ActionParameters = @import("action_parameters.zig").ActionParameters;

/// The details about the specified action configured for an environment. For
/// example, the details of the specified console links for an analytics tool
/// that is available in this environment.
pub const EnvironmentActionSummary = struct {
    /// The environment action description.
    description: ?[]const u8 = null,

    /// The Amazon DataZone domain ID of the environment action.
    domain_id: []const u8,

    /// The environment ID of the environment action.
    environment_id: []const u8,

    /// The ID of the environment action.
    id: []const u8,

    /// The name of the environment action.
    name: []const u8,

    /// The parameters of the environment action.
    parameters: ActionParameters,

    pub const json_field_names = .{
        .description = "description",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .id = "id",
        .name = "name",
        .parameters = "parameters",
    };
};
