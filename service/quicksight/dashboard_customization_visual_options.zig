const VisualCustomizationFieldsConfiguration = @import("visual_customization_fields_configuration.zig").VisualCustomizationFieldsConfiguration;

/// The options that define customizations available to dashboard readers for a
/// specific visual
pub const DashboardCustomizationVisualOptions = struct {
    /// The configuration that controls field customization options available to
    /// dashboard readers for a visual.
    fields_configuration: ?VisualCustomizationFieldsConfiguration,

    pub const json_field_names = .{
        .fields_configuration = "FieldsConfiguration",
    };
};
