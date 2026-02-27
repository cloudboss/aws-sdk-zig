const ToxicContent = @import("toxic_content.zig").ToxicContent;

/// Toxicity analysis result for one string. For more information about toxicity
/// detection, see [Toxicity
/// detection](https://docs.aws.amazon.com/comprehend/latest/dg/toxicity-detection.html) in the *Amazon Comprehend Developer Guide*.
pub const ToxicLabels = struct {
    /// Array of toxic content types identified in the string.
    labels: ?[]const ToxicContent,

    /// Overall toxicity score for the string. Value range is zero to one, where one
    /// is the highest confidence.
    toxicity: ?f32,

    pub const json_field_names = .{
        .labels = "Labels",
        .toxicity = "Toxicity",
    };
};
