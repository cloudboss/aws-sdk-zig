/// Set Style passthrough to ENABLED to use the available style, color, and
/// position information from your input captions. MediaConvert uses default
/// settings for any missing style and position information in your input
/// captions. Set Style passthrough to DISABLED, or leave blank, to ignore the
/// style and position information from your input captions and use simplified
/// output captions.
pub const SrtStylePassthrough = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
