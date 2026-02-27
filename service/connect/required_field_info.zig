const TaskTemplateFieldIdentifier = @import("task_template_field_identifier.zig").TaskTemplateFieldIdentifier;

/// Information about a required field.
pub const RequiredFieldInfo = struct {
    /// The unique identifier for the field.
    id: ?TaskTemplateFieldIdentifier,

    pub const json_field_names = .{
        .id = "Id",
    };
};
