/// An alias for a theme.
pub const ThemeAlias = struct {
    /// The display name of the theme alias.
    alias_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the theme alias.
    arn: ?[]const u8 = null,

    /// The version number of the theme alias.
    theme_version_number: ?i64 = null,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .arn = "Arn",
        .theme_version_number = "ThemeVersionNumber",
    };
};
