const CustomTemplateResponse = @import("custom_template_response.zig").CustomTemplateResponse;
const ManagedTemplateResponse = @import("managed_template_response.zig").ManagedTemplateResponse;

/// Response containing note template settings
pub const NoteTemplateSettingsResponse = union(enum) {
    custom_template: ?CustomTemplateResponse,
    managed_template: ?ManagedTemplateResponse,

    pub const json_field_names = .{
        .custom_template = "customTemplate",
        .managed_template = "managedTemplate",
    };
};
