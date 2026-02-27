const TaskTemplateFieldIdentifier = @import("task_template_field_identifier.zig").TaskTemplateFieldIdentifier;

/// A field that is invisible to an agent.
pub const InvisibleFieldInfo = struct {
    /// Identifier of the invisible field.
    id: ?TaskTemplateFieldIdentifier,

    pub const json_field_names = .{
        .id = "Id",
    };
};
