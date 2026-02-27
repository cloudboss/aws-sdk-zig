const FrameCaptureS3Settings = @import("frame_capture_s3_settings.zig").FrameCaptureS3Settings;

/// Frame Capture Cdn Settings
pub const FrameCaptureCdnSettings = struct {
    frame_capture_s3_settings: ?FrameCaptureS3Settings,

    pub const json_field_names = .{
        .frame_capture_s3_settings = "FrameCaptureS3Settings",
    };
};
