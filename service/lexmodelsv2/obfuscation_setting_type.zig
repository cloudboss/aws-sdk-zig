pub const ObfuscationSettingType = enum {
    none,
    default_obfuscation,

    pub const json_field_names = .{
        .none = "None",
        .default_obfuscation = "DefaultObfuscation",
    };
};
