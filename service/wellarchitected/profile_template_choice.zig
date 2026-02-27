/// A profile template choice.
pub const ProfileTemplateChoice = struct {
    choice_description: ?[]const u8,

    choice_id: ?[]const u8,

    choice_title: ?[]const u8,

    pub const json_field_names = .{
        .choice_description = "ChoiceDescription",
        .choice_id = "ChoiceId",
        .choice_title = "ChoiceTitle",
    };
};
