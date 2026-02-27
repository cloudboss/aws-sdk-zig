/// The template alias.
pub const TemplateAlias = struct {
    /// The display name of the template alias.
    alias_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the template alias.
    arn: ?[]const u8,

    /// The version number of the template alias.
    template_version_number: ?i64,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .arn = "Arn",
        .template_version_number = "TemplateVersionNumber",
    };
};
