const AssetProcessingConfiguration = @import("asset_processing_configuration.zig").AssetProcessingConfiguration;

/// Input configuration.
pub const InputConfiguration = struct {
    /// Asset processing configuration
    asset_processing_configuration: ?AssetProcessingConfiguration = null,

    /// S3 uri.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .asset_processing_configuration = "assetProcessingConfiguration",
        .s_3_uri = "s3Uri",
    };
};
