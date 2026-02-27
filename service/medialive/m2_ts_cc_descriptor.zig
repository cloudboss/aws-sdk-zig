/// M2ts Cc Descriptor
pub const M2tsCcDescriptor = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
