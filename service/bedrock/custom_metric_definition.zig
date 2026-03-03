const RatingScaleItem = @import("rating_scale_item.zig").RatingScaleItem;

/// The definition of a custom metric for use in an Amazon Bedrock evaluation
/// job. A custom metric definition includes a metric name, prompt
/// (instructions) and optionally, a rating scale. Your prompt must include a
/// task description and input variables. The required input variables are
/// different for model-as-a-judge and RAG evaluations.
///
/// For more information about how to define a custom metric in Amazon Bedrock,
/// see [Create a prompt for a custom metrics (LLM-as-a-judge model
/// evaluations)](https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-custom-metrics-prompt-formats.html) and [Create a prompt for a custom metrics (RAG evaluations)](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-evaluation-custom-metrics-prompt-formats.html).
pub const CustomMetricDefinition = struct {
    /// The prompt for a custom metric that instructs the evaluator model how to
    /// rate the model or RAG source under evaluation.
    instructions: []const u8,

    /// The name for a custom metric. Names must be unique in your Amazon Web
    /// Services region.
    name: []const u8,

    /// Defines the rating scale to be used for a custom metric. We recommend that
    /// you always define a ratings scale when creating a custom metric. If you
    /// don't define a scale, Amazon Bedrock won't be able to visually display the
    /// results of the evaluation in the console or calculate average values of
    /// numerical scores. For more information on specifying a rating scale, see
    /// [Specifying an output schema (rating
    /// scale)](https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-custom-metrics-prompt-formats.html#model-evaluation-custom-metrics-prompt-formats-schema).
    rating_scale: ?[]const RatingScaleItem = null,

    pub const json_field_names = .{
        .instructions = "instructions",
        .name = "name",
        .rating_scale = "ratingScale",
    };
};
