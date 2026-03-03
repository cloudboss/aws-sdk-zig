/// Settings related to idle shutdown of Studio applications in a space.
pub const SpaceIdleSettings = struct {
    /// The time that SageMaker waits after the application becomes idle before
    /// shutting it down.
    idle_timeout_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .idle_timeout_in_minutes = "IdleTimeoutInMinutes",
    };
};
