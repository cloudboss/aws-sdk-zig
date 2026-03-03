const VideoSelectorPid = @import("video_selector_pid.zig").VideoSelectorPid;
const VideoSelectorProgramId = @import("video_selector_program_id.zig").VideoSelectorProgramId;

/// Video Selector Settings
pub const VideoSelectorSettings = struct {
    video_selector_pid: ?VideoSelectorPid = null,

    video_selector_program_id: ?VideoSelectorProgramId = null,

    pub const json_field_names = .{
        .video_selector_pid = "VideoSelectorPid",
        .video_selector_program_id = "VideoSelectorProgramId",
    };
};
