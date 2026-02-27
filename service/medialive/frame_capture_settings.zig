const FrameCaptureIntervalUnit = @import("frame_capture_interval_unit.zig").FrameCaptureIntervalUnit;
const TimecodeBurninSettings = @import("timecode_burnin_settings.zig").TimecodeBurninSettings;

/// Frame Capture Settings
pub const FrameCaptureSettings = struct {
    /// The frequency at which to capture frames for inclusion in the output. May be
    /// specified in either seconds or milliseconds, as specified by
    /// captureIntervalUnits.
    capture_interval: ?i32,

    /// Unit for the frame capture interval.
    capture_interval_units: ?FrameCaptureIntervalUnit,

    /// Timecode burn-in settings
    timecode_burnin_settings: ?TimecodeBurninSettings,

    pub const json_field_names = .{
        .capture_interval = "CaptureInterval",
        .capture_interval_units = "CaptureIntervalUnits",
        .timecode_burnin_settings = "TimecodeBurninSettings",
    };
};
