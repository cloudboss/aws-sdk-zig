const VideoAssetProcessingConfiguration = @import("video_asset_processing_configuration.zig").VideoAssetProcessingConfiguration;

/// Config containing asset processing related knobs for all modalities
pub const AssetProcessingConfiguration = struct {
    /// Video asset processing configuration
    video: ?VideoAssetProcessingConfiguration,

    pub const json_field_names = .{
        .video = "video",
    };
};
