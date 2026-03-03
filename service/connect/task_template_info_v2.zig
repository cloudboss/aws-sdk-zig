/// Information about the task template used to create this contact.
pub const TaskTemplateInfoV2 = struct {
    /// The Amazon Resource Name (ARN) of the task template used to create this
    /// contact.
    arn: ?[]const u8 = null,

    /// The name of the task template used to create this contact.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
