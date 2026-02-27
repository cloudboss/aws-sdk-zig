const DashboardVisualResult = @import("dashboard_visual_result.zig").DashboardVisualResult;
const GeneratedAnswerResult = @import("generated_answer_result.zig").GeneratedAnswerResult;
const QAResultType = @import("qa_result_type.zig").QAResultType;

/// The QA result that is made from the `DashboardVisual` or `GeneratedAnswer`.
pub const QAResult = struct {
    /// The representation of a dashboard visual result.
    dashboard_visual: ?DashboardVisualResult,

    /// The representation of a generated answer result.
    generated_answer: ?GeneratedAnswerResult,

    /// The type of QA result.
    result_type: ?QAResultType,

    pub const json_field_names = .{
        .dashboard_visual = "DashboardVisual",
        .generated_answer = "GeneratedAnswer",
        .result_type = "ResultType",
    };
};
