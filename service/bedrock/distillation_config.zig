const TeacherModelConfig = @import("teacher_model_config.zig").TeacherModelConfig;

/// Settings for distilling a foundation model into a smaller and more efficient
/// model.
pub const DistillationConfig = struct {
    /// The teacher model configuration.
    teacher_model_config: TeacherModelConfig,

    pub const json_field_names = .{
        .teacher_model_config = "teacherModelConfig",
    };
};
