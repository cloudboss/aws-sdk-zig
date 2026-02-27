/// Filter the flywheel iterations based on creation time.
pub const FlywheelIterationFilter = struct {
    /// Filter the flywheel iterations to include iterations created after the
    /// specified time.
    creation_time_after: ?i64,

    /// Filter the flywheel iterations to include iterations created before the
    /// specified time.
    creation_time_before: ?i64,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
    };
};
