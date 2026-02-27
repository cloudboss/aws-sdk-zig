/// Add texture and detail to areas of your input video content that were lost
/// after applying the Advanced input filter. To adaptively add texture and
/// reduce softness: Choose Enabled. To not add any texture: Keep the default
/// value, Disabled. We recommend that you choose Disabled for input video
/// content that doesn't have texture, including screen recordings, computer
/// graphics, or cartoons.
pub const AdvancedInputFilterAddTexture = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
