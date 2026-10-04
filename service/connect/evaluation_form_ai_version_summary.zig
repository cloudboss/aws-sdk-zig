const EvaluationFormAIVersionLifecycle = @import("evaluation_form_ai_version_lifecycle.zig").EvaluationFormAIVersionLifecycle;

/// Contains the name and lifecycle information for an AI version that you can
/// use when creating or updating an evaluation form.
pub const EvaluationFormAIVersionSummary = struct {
    /// The lifecycle information for this AI version, including its status and
    /// availability dates.
    ai_version_lifecycle: EvaluationFormAIVersionLifecycle,

    /// The name of the AI version.
    ai_version_name: []const u8,

    pub const json_field_names = .{
        .ai_version_lifecycle = "AIVersionLifecycle",
        .ai_version_name = "AIVersionName",
    };
};
