/// State of Nielsen PCM to ID3 tagging
pub const NielsenPcmToId3TaggingState = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
