/// Details about a teacher model used for model customization.
pub const TeacherModelConfig = struct {
    /// The maximum number of tokens requested when the customization job invokes
    /// the teacher model.
    max_response_length_for_inference: ?i32,

    /// The identifier of the teacher model.
    teacher_model_identifier: []const u8,

    pub const json_field_names = .{
        .max_response_length_for_inference = "maxResponseLengthForInference",
        .teacher_model_identifier = "teacherModelIdentifier",
    };
};
