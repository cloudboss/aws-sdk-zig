/// Timeout Config for preview contacts.
pub const TimeoutConfig = struct {
    duration_in_seconds: i32,

    pub const json_field_names = .{
        .duration_in_seconds = "durationInSeconds",
    };
};
