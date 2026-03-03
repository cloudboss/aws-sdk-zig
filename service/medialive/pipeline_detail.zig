const ChannelEngineVersionResponse = @import("channel_engine_version_response.zig").ChannelEngineVersionResponse;

/// Runtime details of a pipeline when a channel is running.
pub const PipelineDetail = struct {
    /// The name of the active input attachment currently being ingested by this
    /// pipeline.
    active_input_attachment_name: ?[]const u8 = null,

    /// The name of the input switch schedule action that occurred most recently and
    /// that resulted in the switch to the current input attachment for this
    /// pipeline.
    active_input_switch_action_name: ?[]const u8 = null,

    /// The name of the motion graphics activate action that occurred most recently
    /// and that resulted in the current graphics URI for this pipeline.
    active_motion_graphics_action_name: ?[]const u8 = null,

    /// The current URI being used for HTML5 motion graphics for this pipeline.
    active_motion_graphics_uri: ?[]const u8 = null,

    /// Current engine version of the encoder for this pipeline.
    channel_engine_version: ?ChannelEngineVersionResponse = null,

    /// Pipeline ID
    pipeline_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_input_attachment_name = "ActiveInputAttachmentName",
        .active_input_switch_action_name = "ActiveInputSwitchActionName",
        .active_motion_graphics_action_name = "ActiveMotionGraphicsActionName",
        .active_motion_graphics_uri = "ActiveMotionGraphicsUri",
        .channel_engine_version = "ChannelEngineVersion",
        .pipeline_id = "PipelineId",
    };
};
