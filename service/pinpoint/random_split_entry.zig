/// Specifies the settings for a path in a random split activity in a journey.
pub const RandomSplitEntry = struct {
    /// The unique identifier for the next activity to perform, after completing the
    /// activity for the path.
    next_activity: ?[]const u8,

    /// The percentage of participants to send down the activity path.
    ///
    /// To determine which participants are sent down each path, Amazon Pinpoint
    /// applies a probability-based algorithm to the percentages that you specify
    /// for the paths. Therefore, the actual percentage of participants who are sent
    /// down a path may not be equal to the percentage that you specify.
    percentage: ?i32,

    pub const json_field_names = .{
        .next_activity = "NextActivity",
        .percentage = "Percentage",
    };
};
