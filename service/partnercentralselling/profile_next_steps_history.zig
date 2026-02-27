/// Tracks the history of next steps associated with the opportunity. This field
/// captures the actions planned for the future and their timeline.
pub const ProfileNextStepsHistory = struct {
    /// Indicates the date and time when a particular next step was recorded or
    /// planned. This helps in managing the timeline for the opportunity.
    time: i64,

    /// Represents the details of the next step recorded, such as follow-up actions
    /// or decisions made. This field helps in tracking progress and ensuring
    /// alignment with project goals.
    value: []const u8,

    pub const json_field_names = .{
        .time = "Time",
        .value = "Value",
    };
};
