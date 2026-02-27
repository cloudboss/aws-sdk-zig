const ObfuscationSettingType = @import("obfuscation_setting_type.zig").ObfuscationSettingType;

/// Determines whether Amazon Lex obscures slot values in conversation logs.
pub const ObfuscationSetting = struct {
    /// Value that determines whether Amazon Lex obscures slot values in
    /// conversation logs. The default is to obscure the values.
    obfuscation_setting_type: ObfuscationSettingType,

    pub const json_field_names = .{
        .obfuscation_setting_type = "obfuscationSettingType",
    };
};
