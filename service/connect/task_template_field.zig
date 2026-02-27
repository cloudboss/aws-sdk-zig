const TaskTemplateFieldIdentifier = @import("task_template_field_identifier.zig").TaskTemplateFieldIdentifier;
const TaskTemplateFieldType = @import("task_template_field_type.zig").TaskTemplateFieldType;

/// Describes a single task template field.
pub const TaskTemplateField = struct {
    /// The description of the field.
    description: ?[]const u8,

    /// The unique identifier for the field.
    id: TaskTemplateFieldIdentifier,

    /// A list of options for a single select field.
    single_select_options: ?[]const []const u8,

    /// Indicates the type of field.
    type: ?TaskTemplateFieldType,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .single_select_options = "SingleSelectOptions",
        .type = "Type",
    };
};
