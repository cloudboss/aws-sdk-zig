/// Information about the points configuration for a question.
pub const QuestionPointsConfiguration = struct {
    /// The flag to mark the question as a bonus question.
    is_bonus: bool = false,

    /// The maximum point value.
    max_point_value: i32 = 0,

    /// The minimum point value.
    min_point_value: i32 = 0,

    pub const json_field_names = .{
        .is_bonus = "IsBonus",
        .max_point_value = "MaxPointValue",
        .min_point_value = "MinPointValue",
    };
};
