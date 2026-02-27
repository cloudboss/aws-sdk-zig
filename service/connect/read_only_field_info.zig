const TaskTemplateFieldIdentifier = @import("task_template_field_identifier.zig").TaskTemplateFieldIdentifier;

/// Indicates a field that is read-only to an agent.
pub const ReadOnlyFieldInfo = struct {
    /// Identifier of the read-only field.
    id: ?TaskTemplateFieldIdentifier,

    pub const json_field_names = .{
        .id = "Id",
    };
};
