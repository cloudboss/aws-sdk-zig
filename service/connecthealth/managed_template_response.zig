const ManagedNoteTemplate = @import("managed_note_template.zig").ManagedNoteTemplate;

/// Response containing managed template information
pub const ManagedTemplateResponse = struct {
    /// The type of managed template used
    template_type: ?ManagedNoteTemplate = null,

    pub const json_field_names = .{
        .template_type = "templateType",
    };
};
