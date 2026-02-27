const MultiplexStatmuxVideoSettings = @import("multiplex_statmux_video_settings.zig").MultiplexStatmuxVideoSettings;

/// The video configuration for each program in a multiplex.
pub const MultiplexVideoSettings = struct {
    /// The constant bitrate configuration for the video encode.
    /// When this field is defined, StatmuxSettings must be undefined.
    constant_bitrate: ?i32,

    /// Statmux rate control settings.
    /// When this field is defined, ConstantBitrate must be undefined.
    statmux_settings: ?MultiplexStatmuxVideoSettings,

    pub const json_field_names = .{
        .constant_bitrate = "ConstantBitrate",
        .statmux_settings = "StatmuxSettings",
    };
};
