const EvaluationQuestionAnswerAnalysisDetails = @import("evaluation_question_answer_analysis_details.zig").EvaluationQuestionAnswerAnalysisDetails;
const EvaluationQuestionAnswerAnalysisType = @import("evaluation_question_answer_analysis_type.zig").EvaluationQuestionAnswerAnalysisType;
const EvaluationQuestionInputDetails = @import("evaluation_question_input_details.zig").EvaluationQuestionInputDetails;
const EvaluationSuggestedAnswerStatus = @import("evaluation_suggested_answer_status.zig").EvaluationSuggestedAnswerStatus;
const EvaluationAnswerData = @import("evaluation_answer_data.zig").EvaluationAnswerData;

/// The information about the suggested answer for the question.
pub const EvaluationSuggestedAnswer = struct {
    /// Detailed analysis results.
    analysis_details: ?EvaluationQuestionAnswerAnalysisDetails = null,

    /// Type of analysis used to provide suggested answer.
    analysis_type: EvaluationQuestionAnswerAnalysisType,

    /// Details about the input used to question automation.
    input: ?EvaluationQuestionInputDetails = null,

    /// The status of the suggested answer. D
    status: EvaluationSuggestedAnswerStatus,

    value: ?EvaluationAnswerData = null,

    pub const json_field_names = .{
        .analysis_details = "AnalysisDetails",
        .analysis_type = "AnalysisType",
        .input = "Input",
        .status = "Status",
        .value = "Value",
    };
};
