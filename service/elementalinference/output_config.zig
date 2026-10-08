const ClippingConfig = @import("clipping_config.zig").ClippingConfig;
const ContextualMetadataConfig = @import("contextual_metadata_config.zig").ContextualMetadataConfig;
const CroppingConfig = @import("cropping_config.zig").CroppingConfig;
const SubtitlingConfig = @import("subtitling_config.zig").SubtitlingConfig;

/// Contains one typed output. It is used in the CreateOutput, GetOutput, and
/// Update Output structures.
pub const OutputConfig = union(enum) {
    /// The output config type that applies to the clipping feature.
    clipping: ?ClippingConfig,
    /// The output config type that applies to the contextual metadata feature.
    contextual_metadata: ?ContextualMetadataConfig,
    /// The output config type that applies to the cropping feature.
    cropping: ?CroppingConfig,
    /// The output config type that applies to the smart subtitling feature.
    subtitling: ?SubtitlingConfig,

    pub const json_field_names = .{
        .clipping = "clipping",
        .contextual_metadata = "contextualMetadata",
        .cropping = "cropping",
        .subtitling = "subtitling",
    };
};
