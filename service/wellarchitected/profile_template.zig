const ProfileTemplateQuestion = @import("profile_template_question.zig").ProfileTemplateQuestion;

/// The profile template.
pub const ProfileTemplate = struct {
    created_at: ?i64,

    /// The name of the profile template.
    template_name: ?[]const u8,

    /// Profile template questions.
    template_questions: ?[]const ProfileTemplateQuestion,

    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .template_name = "TemplateName",
        .template_questions = "TemplateQuestions",
        .updated_at = "UpdatedAt",
    };
};
