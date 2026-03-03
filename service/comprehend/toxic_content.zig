const ToxicContentType = @import("toxic_content_type.zig").ToxicContentType;

/// Toxic content analysis result for one string. For more information about
/// toxicity detection, see [Toxicity
/// detection](https://docs.aws.amazon.com/comprehend/latest/dg/toxicity-detection.html) in the *Amazon Comprehend Developer Guide*
pub const ToxicContent = struct {
    /// The name of the toxic content type.
    name: ?ToxicContentType = null,

    /// Model confidence in the detected content type. Value range is zero to one,
    /// where one is highest confidence.
    score: ?f32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .score = "Score",
    };
};
