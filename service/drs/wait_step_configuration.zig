/// Configuration for a `WAIT` type step.
pub const WaitStepConfiguration = struct {
    wait_duration_minutes: i32,

    pub const json_field_names = .{
        .wait_duration_minutes = "waitDurationMinutes",
    };
};
