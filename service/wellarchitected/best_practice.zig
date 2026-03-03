/// A best practice, or question choice, that has been identified as a risk in
/// this question.
pub const BestPractice = struct {
    choice_id: ?[]const u8 = null,

    choice_title: ?[]const u8 = null,

    pub const json_field_names = .{
        .choice_id = "ChoiceId",
        .choice_title = "ChoiceTitle",
    };
};
