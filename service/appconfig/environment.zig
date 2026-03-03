const Monitor = @import("monitor.zig").Monitor;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const Environment = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The description of the environment.
    description: ?[]const u8 = null,

    /// The environment ID.
    id: ?[]const u8 = null,

    /// Amazon CloudWatch alarms monitored during the deployment.
    monitors: ?[]const Monitor = null,

    /// The name of the environment.
    name: ?[]const u8 = null,

    /// The state of the environment. An environment can be in one of the following
    /// states:
    /// `READY_FOR_DEPLOYMENT`, `DEPLOYING`, `ROLLING_BACK`, or
    /// `ROLLED_BACK`
    state: ?EnvironmentState = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .description = "Description",
        .id = "Id",
        .monitors = "Monitors",
        .name = "Name",
        .state = "State",
    };
};
