/// Information about the points configuration for an answer option.
pub const QuestionOptionPointsConfiguration = struct {
    /// The flag to mark the option as a bonus option.
    is_bonus: bool = false,

    /// The point value assigned to the answer option.
    point_value: i32 = 0,

    pub const json_field_names = .{
        .is_bonus = "IsBonus",
        .point_value = "PointValue",
    };
};
