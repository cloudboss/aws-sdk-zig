const MediaLiveTransitEncryption = @import("media_live_transit_encryption.zig").MediaLiveTransitEncryption;
const MediaLiveInputPipelineId = @import("media_live_input_pipeline_id.zig").MediaLiveInputPipelineId;

/// Configuration settings for connecting a router output to a MediaLive input.
pub const MediaLiveInputRouterOutputConfiguration = struct {
    /// The encryption configuration for the MediaLive input when connected to this
    /// router output.
    destination_transit_encryption: MediaLiveTransitEncryption,

    /// The ARN of the MediaLive input to connect to this router output.
    media_live_input_arn: ?[]const u8 = null,

    /// The index of the MediaLive pipeline to connect to this router output.
    media_live_pipeline_id: ?MediaLiveInputPipelineId = null,

    pub const json_field_names = .{
        .destination_transit_encryption = "DestinationTransitEncryption",
        .media_live_input_arn = "MediaLiveInputArn",
        .media_live_pipeline_id = "MediaLivePipelineId",
    };
};
