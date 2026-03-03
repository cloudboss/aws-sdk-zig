const TopicIR = @import("topic_ir.zig").TopicIR;
const TopicVisual = @import("topic_visual.zig").TopicVisual;
const TopicTemplate = @import("topic_template.zig").TopicTemplate;

/// The definition for a `CreateTopicReviewedAnswer`.
pub const CreateTopicReviewedAnswer = struct {
    /// The answer ID for the `CreateTopicReviewedAnswer`.
    answer_id: []const u8,

    /// The Dataset arn for the `CreateTopicReviewedAnswer`.
    dataset_arn: []const u8,

    /// The Mir for the `CreateTopicReviewedAnswer`.
    mir: ?TopicIR = null,

    /// The `PrimaryVisual` for the `CreateTopicReviewedAnswer`.
    primary_visual: ?TopicVisual = null,

    /// The Question to be created.
    question: []const u8,

    /// The template for the `CreateTopicReviewedAnswer`.
    template: ?TopicTemplate = null,

    pub const json_field_names = .{
        .answer_id = "AnswerId",
        .dataset_arn = "DatasetArn",
        .mir = "Mir",
        .primary_visual = "PrimaryVisual",
        .question = "Question",
        .template = "Template",
    };
};
