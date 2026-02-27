const EmotionName = @import("emotion_name.zig").EmotionName;

/// The API returns a prediction of an emotion based on a person's facial
/// expressions, along with
/// the confidence level for the predicted emotion. It is not a determination of
/// the person’s internal emotional
/// state and should not be used in such a way. For example, a person pretending
/// to have a sad face might not
/// be sad emotionally. The API is not intended to be used, and you may not use
/// it, in a manner that violates
/// the EU Artificial Intelligence Act or any other applicable law.
pub const Emotion = struct {
    /// Level of confidence in the determination.
    confidence: ?f32,

    /// Type of emotion detected.
    type: ?EmotionName,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .type = "Type",
    };
};
