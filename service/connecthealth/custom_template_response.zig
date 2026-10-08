const CustomTemplateBase = @import("custom_template_base.zig").CustomTemplateBase;

/// Response containing custom template information
pub const CustomTemplateResponse = struct {
    /// The base template type that was customized
    template_type: ?CustomTemplateBase = null,

    pub const json_field_names = .{
        .template_type = "templateType",
    };
};
