const ExecuteCommandSessionConfiguration = @import("execute_command_session_configuration.zig").ExecuteCommandSessionConfiguration;
const DevEnvironmentSessionType = @import("dev_environment_session_type.zig").DevEnvironmentSessionType;

/// Information about the configuration of a Dev Environment session.
pub const DevEnvironmentSessionConfiguration = struct {
    /// Information about optional commands that will be run on the Dev Environment
    /// when the SSH session begins.
    execute_command_session_configuration: ?ExecuteCommandSessionConfiguration = null,

    /// The type of the session.
    session_type: DevEnvironmentSessionType,

    pub const json_field_names = .{
        .execute_command_session_configuration = "executeCommandSessionConfiguration",
        .session_type = "sessionType",
    };
};
