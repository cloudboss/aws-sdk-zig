/// The summary of the template.
pub const TemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the template.
    arn: ?[]const u8,

    /// The description of the template.
    description: ?[]const u8,

    /// The ID of the template.
    id: ?[]const u8,

    /// The name of the template.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .id = "id",
        .name = "name",
    };
};
