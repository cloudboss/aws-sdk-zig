/// Set to ENABLED to force a rendition to be included.
pub const RequiredFlag = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
