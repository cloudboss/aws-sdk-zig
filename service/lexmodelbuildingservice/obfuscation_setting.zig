pub const ObfuscationSetting = enum {
    none,
    default_obfuscation,

    pub const json_field_names = .{
        .none = "NONE",
        .default_obfuscation = "DEFAULT_OBFUSCATION",
    };
};
