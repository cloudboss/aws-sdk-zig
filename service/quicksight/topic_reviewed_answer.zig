const TopicIR = @import("topic_ir.zig").TopicIR;
const TopicVisual = @import("topic_visual.zig").TopicVisual;
const TopicTemplate = @import("topic_template.zig").TopicTemplate;

/// The deinition for a `TopicReviewedAnswer`.
pub const TopicReviewedAnswer = struct {
    /// The answer ID of the reviewed answer.
    answer_id: []const u8,

    /// The Amazon Resource Name (ARN) of the reviewed answer.
    arn: ?[]const u8,

    /// The Dataset ARN for the `TopicReviewedAnswer`.
    dataset_arn: []const u8,

    /// The mir for the `TopicReviewedAnswer`.
    mir: ?TopicIR,

    /// The primary visual for the `TopicReviewedAnswer`.
    primary_visual: ?TopicVisual,

    /// The question for the `TopicReviewedAnswer`.
    question: []const u8,

    /// The template for the `TopicReviewedAnswer`.
    template: ?TopicTemplate,

    pub const json_field_names = .{
        .answer_id = "AnswerId",
        .arn = "Arn",
        .dataset_arn = "DatasetArn",
        .mir = "Mir",
        .primary_visual = "PrimaryVisual",
        .question = "Question",
        .template = "Template",
    };
};
