const CustomTemplate = @import("custom_template.zig").CustomTemplate;
const ManagedTemplate = @import("managed_template.zig").ManagedTemplate;

/// Settings for the note template to use for clinical note generation
pub const NoteTemplateSettings = union(enum) {
    custom_template: ?CustomTemplate,
    managed_template: ?ManagedTemplate,

    pub const json_field_names = .{
        .custom_template = "customTemplate",
        .managed_template = "managedTemplate",
    };
};
