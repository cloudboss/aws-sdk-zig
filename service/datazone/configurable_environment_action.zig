const ConfigurableActionTypeAuthorization = @import("configurable_action_type_authorization.zig").ConfigurableActionTypeAuthorization;
const ConfigurableActionParameter = @import("configurable_action_parameter.zig").ConfigurableActionParameter;

/// The configurable action of a Amazon DataZone environment.
pub const ConfigurableEnvironmentAction = struct {
    /// The authentication type of a configurable action of a Amazon DataZone
    /// environment.
    auth: ?ConfigurableActionTypeAuthorization = null,

    /// The parameters of a configurable action in a Amazon DataZone environment.
    parameters: []const ConfigurableActionParameter,

    /// The type of a configurable action in a Amazon DataZone environment.
    @"type": []const u8,

    pub const json_field_names = .{
        .auth = "auth",
        .parameters = "parameters",
        .@"type" = "type",
    };
};
