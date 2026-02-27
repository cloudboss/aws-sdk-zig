const EvaluationFormLanguageCode = @import("evaluation_form_language_code.zig").EvaluationFormLanguageCode;

/// Language configuration for an evaluation form.
pub const EvaluationFormLanguageConfiguration = struct {
    /// The language for the evaluation form.
    form_language: ?EvaluationFormLanguageCode,

    pub const json_field_names = .{
        .form_language = "FormLanguage",
    };
};
