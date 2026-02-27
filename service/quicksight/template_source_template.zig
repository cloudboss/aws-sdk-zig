/// The source template of the template.
pub const TemplateSourceTemplate = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
