/// Specifies the settings for a holdout activity in a journey. This type of
/// activity stops a journey for a specified percentage of participants.
pub const HoldoutActivity = struct {
    /// The unique identifier for the next activity to perform, after performing the
    /// holdout activity.
    next_activity: ?[]const u8,

    /// The percentage of participants who shouldn't continue the journey.
    ///
    /// To determine which participants are held out, Amazon Pinpoint applies a
    /// probability-based algorithm to the percentage that you specify. Therefore,
    /// the actual percentage of participants who are held out may not be equal to
    /// the percentage that you specify.
    percentage: i32,

    pub const json_field_names = .{
        .next_activity = "NextActivity",
        .percentage = "Percentage",
    };
};
