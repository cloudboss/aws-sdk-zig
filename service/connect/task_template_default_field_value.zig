const TaskTemplateFieldIdentifier = @import("task_template_field_identifier.zig").TaskTemplateFieldIdentifier;

/// Describes a default field and its corresponding value.
pub const TaskTemplateDefaultFieldValue = struct {
    /// Default value for the field.
    default_value: ?[]const u8 = null,

    /// Identifier of a field.
    id: ?TaskTemplateFieldIdentifier = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .id = "Id",
    };
};
