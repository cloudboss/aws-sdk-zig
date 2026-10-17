const MediaLiveTransitEncryption = @import("media_live_transit_encryption.zig").MediaLiveTransitEncryption;
const MediaLiveInputPipelineId = @import("media_live_input_pipeline_id.zig").MediaLiveInputPipelineId;

/// Configuration settings for connecting a router output to a MediaLive input.
///
/// To connect the router output to the MediaLive input, provide both
/// `mediaLiveInputArn` and `mediaLivePipelineId`. To disconnect it, call the
/// update operation and omit both fields while keeping this configuration
/// object.
///
/// You can't change `destinationTransitEncryption` while the router output is
/// connected to a MediaLive input. To change it, first disconnect the router
/// output, then update the encryption.
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
