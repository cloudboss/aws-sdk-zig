const ElementalInferenceFeature = @import("elemental_inference_feature.zig").ElementalInferenceFeature;
const ElementalInferenceFeed = @import("elemental_inference_feed.zig").ElementalInferenceFeed;

/// The Elemental Inference configuration used in this job.
pub const ElementalInferenceConfiguration = struct {
    /// A list of Elemental Inference features used in this job.
    features: ?[]const ElementalInferenceFeature = null,

    /// A list of Elemental Inference feeds used by this job.
    feeds: ?[]const ElementalInferenceFeed = null,

    pub const json_field_names = .{
        .features = "Features",
        .feeds = "Feeds",
    };
};
