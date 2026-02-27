const ToxicityCategory = @import("toxicity_category.zig").ToxicityCategory;

/// Contains `ToxicityCategories`, which is a required parameter if you
/// want to enable toxicity detection (`ToxicityDetection`) in your
/// transcription
/// request.
pub const ToxicityDetectionSettings = struct {
    /// If you include `ToxicityDetection` in your transcription request, you
    /// must also include `ToxicityCategories`. The only accepted value for this
    /// parameter is `ALL`.
    toxicity_categories: []const ToxicityCategory,

    pub const json_field_names = .{
        .toxicity_categories = "ToxicityCategories",
    };
};
