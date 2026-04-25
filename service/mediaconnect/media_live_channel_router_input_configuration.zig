const MediaLiveChannelPipelineId = @import("media_live_channel_pipeline_id.zig").MediaLiveChannelPipelineId;
const MediaLiveTransitEncryption = @import("media_live_transit_encryption.zig").MediaLiveTransitEncryption;

/// Configuration settings for connecting a router input to a MediaLive channel
/// output.
pub const MediaLiveChannelRouterInputConfiguration = struct {
    /// The ARN of the MediaLive channel to connect to this router input.
    media_live_channel_arn: ?[]const u8 = null,

    /// The name of the MediaLive channel output to connect to this router input.
    media_live_channel_output_name: ?[]const u8 = null,

    /// The index of the MediaLive pipeline to connect to this router input.
    media_live_pipeline_id: ?MediaLiveChannelPipelineId = null,

    source_transit_decryption: MediaLiveTransitEncryption,

    pub const json_field_names = .{
        .media_live_channel_arn = "MediaLiveChannelArn",
        .media_live_channel_output_name = "MediaLiveChannelOutputName",
        .media_live_pipeline_id = "MediaLivePipelineId",
        .source_transit_decryption = "SourceTransitDecryption",
    };
};
