/// Specify whether the encoder uses B-frames as reference frames for other
/// pictures in the same GOP. Choose Allow to allow the encoder to use B-frames
/// as reference frames. Choose Don't allow to prevent the encoder from using
/// B-frames as reference frames.
pub const XavcGopBReference = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
