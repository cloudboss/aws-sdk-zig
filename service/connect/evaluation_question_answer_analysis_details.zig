const EvaluationContactLensAnswerAnalysisDetails = @import("evaluation_contact_lens_answer_analysis_details.zig").EvaluationContactLensAnswerAnalysisDetails;
const EvaluationGenAIAnswerAnalysisDetails = @import("evaluation_gen_ai_answer_analysis_details.zig").EvaluationGenAIAnswerAnalysisDetails;

/// Detailed analysis results of the automated answer to the evaluation
/// question.
pub const EvaluationQuestionAnswerAnalysisDetails = union(enum) {
    /// Analysis results from the Contact Lens automation for the question.
    contact_lens: ?EvaluationContactLensAnswerAnalysisDetails,
    /// Analysis results from the generative AI automation for the question.
    gen_ai: ?EvaluationGenAIAnswerAnalysisDetails,

    pub const json_field_names = .{
        .contact_lens = "ContactLens",
        .gen_ai = "GenAI",
    };
};
