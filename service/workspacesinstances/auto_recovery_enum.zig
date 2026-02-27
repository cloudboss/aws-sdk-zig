pub const AutoRecoveryEnum = enum {
    disabled,
    default,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .default = "DEFAULT",
    };
};
