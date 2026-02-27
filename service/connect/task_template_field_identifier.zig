/// The identifier of the task template field.
pub const TaskTemplateFieldIdentifier = struct {
    /// The name of the task template field.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
