const ControlAssessmentResult = @import("control_assessment_result.zig").ControlAssessmentResult;
const ControlError = @import("control_error.zig").ControlError;

/// The result of evaluating a single control as part of an assessment.
pub const ControlAssessment = struct {
    /// The result of the control evaluation.
    control_assessment_result: ?ControlAssessmentResult = null,

    /// The unique ID of the control that was evaluated.
    control_id: ?[]const u8 = null,

    /// An array of `ControlError` objects associated with the control
    /// evaluation.
    errors: ?[]const ControlError = null,

    pub const json_field_names = .{
        .control_assessment_result = "ControlAssessmentResult",
        .control_id = "ControlId",
        .errors = "Errors",
    };
};
