/// The profile choice.
pub const ProfileChoice = struct {
    choice_description: ?[]const u8 = null,

    choice_id: ?[]const u8 = null,

    choice_title: ?[]const u8 = null,

    pub const json_field_names = .{
        .choice_description = "ChoiceDescription",
        .choice_id = "ChoiceId",
        .choice_title = "ChoiceTitle",
    };
};
