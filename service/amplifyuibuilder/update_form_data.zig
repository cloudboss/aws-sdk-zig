const aws = @import("aws");

const FormCTA = @import("form_cta.zig").FormCTA;
const FormDataTypeConfig = @import("form_data_type_config.zig").FormDataTypeConfig;
const FieldConfig = @import("field_config.zig").FieldConfig;
const FormActionType = @import("form_action_type.zig").FormActionType;
const LabelDecorator = @import("label_decorator.zig").LabelDecorator;
const SectionalElement = @import("sectional_element.zig").SectionalElement;
const FormStyle = @import("form_style.zig").FormStyle;

/// Updates and saves all of the information about a form, based on form ID.
pub const UpdateFormData = struct {
    /// The `FormCTA` object that stores the call to action configuration for the
    /// form.
    cta: ?FormCTA,

    /// The type of data source to use to create the form.
    data_type: ?FormDataTypeConfig,

    /// The configuration information for the form's fields.
    fields: ?[]const aws.map.MapEntry(FieldConfig),

    /// Specifies whether to perform a create or update action on the form.
    form_action_type: ?FormActionType,

    /// Specifies an icon or decoration to display on the form.
    label_decorator: ?LabelDecorator,

    /// The name of the form.
    name: ?[]const u8,

    /// The schema version of the form.
    schema_version: ?[]const u8,

    /// The configuration information for the visual helper elements for the form.
    /// These elements
    /// are not associated with any data.
    sectional_elements: ?[]const aws.map.MapEntry(SectionalElement),

    /// The configuration for the form's style.
    style: ?FormStyle,

    pub const json_field_names = .{
        .cta = "cta",
        .data_type = "dataType",
        .fields = "fields",
        .form_action_type = "formActionType",
        .label_decorator = "labelDecorator",
        .name = "name",
        .schema_version = "schemaVersion",
        .sectional_elements = "sectionalElements",
        .style = "style",
    };
};
