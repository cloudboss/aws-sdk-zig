pub const ToolbarItem = enum {
    windows,
    dual_monitor,
    full_screen,
    webcam,
    microphone,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .dual_monitor = "DUAL_MONITOR",
        .full_screen = "FULL_SCREEN",
        .webcam = "WEBCAM",
        .microphone = "MICROPHONE",
    };
};
