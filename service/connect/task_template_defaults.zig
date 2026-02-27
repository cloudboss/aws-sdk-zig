const TaskTemplateDefaultFieldValue = @import("task_template_default_field_value.zig").TaskTemplateDefaultFieldValue;

/// Describes default values for fields on a template.
pub const TaskTemplateDefaults = struct {
    /// Default value for the field.
    default_field_values: ?[]const TaskTemplateDefaultFieldValue,

    pub const json_field_names = .{
        .default_field_values = "DefaultFieldValues",
    };
};
