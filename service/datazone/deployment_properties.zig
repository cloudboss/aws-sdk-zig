/// The deployment properties of the Amazon DataZone blueprint.
pub const DeploymentProperties = struct {
    /// The end timeout of the environment blueprint deployment.
    end_timeout_minutes: ?i32,

    /// The start timeout of the environment blueprint deployment.
    start_timeout_minutes: ?i32,

    pub const json_field_names = .{
        .end_timeout_minutes = "endTimeoutMinutes",
        .start_timeout_minutes = "startTimeoutMinutes",
    };
};
