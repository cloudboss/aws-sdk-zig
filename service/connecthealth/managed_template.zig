const ManagedNoteTemplate = @import("managed_note_template.zig").ManagedNoteTemplate;

/// Configuration for using a managed note template
pub const ManagedTemplate = struct {
    /// The type of managed template to use
    template_type: ManagedNoteTemplate,

    pub const json_field_names = .{
        .template_type = "templateType",
    };
};
