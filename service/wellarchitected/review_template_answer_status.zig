pub const ReviewTemplateAnswerStatus = enum {
    unanswered,
    answered,

    pub const json_field_names = .{
        .unanswered = "UNANSWERED",
        .answered = "ANSWERED",
    };
};
