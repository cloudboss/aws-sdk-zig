/// Applies only to 29.97 fps outputs. When this feature is enabled, the service
/// will use drop-frame timecode on outputs. If it is not possible to use
/// drop-frame timecode, the system will fall back to non-drop-frame. This
/// setting is enabled by default when Timecode insertion or Timecode track is
/// enabled.
pub const DropFrameTimecode = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
