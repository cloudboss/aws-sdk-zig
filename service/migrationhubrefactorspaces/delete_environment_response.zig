const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const DeleteEnvironmentResponse = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8,

    /// A timestamp that indicates when the environment was last updated.
    last_updated_time: ?i64,

    /// The name of the environment.
    name: ?[]const u8,

    /// The current state of the environment.
    state: ?EnvironmentState,

    pub const json_field_names = .{
        .arn = "Arn",
        .environment_id = "EnvironmentId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .state = "State",
    };
};
