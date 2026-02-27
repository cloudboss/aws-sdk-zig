/// Cmaf Id3 Behavior
pub const CmafId3Behavior = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
