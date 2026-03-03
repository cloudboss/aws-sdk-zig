const aws = @import("aws");

const FormCTA = @import("form_cta.zig").FormCTA;
const FormDataTypeConfig = @import("form_data_type_config.zig").FormDataTypeConfig;
const FieldConfig = @import("field_config.zig").FieldConfig;
const FormActionType = @import("form_action_type.zig").FormActionType;
const LabelDecorator = @import("label_decorator.zig").LabelDecorator;
const SectionalElement = @import("sectional_element.zig").SectionalElement;
const FormStyle = @import("form_style.zig").FormStyle;

/// Contains the configuration settings for a `Form` user interface (UI) element
/// for an Amplify app. A form is a component you can add to your project by
/// specifying a data
/// source as the default configuration for the form.
pub const Form = struct {
    /// The unique ID of the Amplify app associated with the form.
    app_id: []const u8,

    /// Stores the call to action configuration for the form.
    cta: ?FormCTA = null,

    /// The type of data source to use to create the form.
    data_type: FormDataTypeConfig,

    /// The name of the backend environment that is a part of the Amplify app.
    environment_name: []const u8,

    /// Stores the information about the form's fields.
    fields: []const aws.map.MapEntry(FieldConfig),

    /// The operation to perform on the specified form.
    form_action_type: FormActionType,

    /// The unique ID of the form.
    id: []const u8,

    /// Specifies an icon or decoration to display on the form.
    label_decorator: ?LabelDecorator = null,

    /// The name of the form.
    name: []const u8,

    /// The schema version of the form when it was imported.
    schema_version: []const u8,

    /// Stores the visual helper elements for the form that are not associated with
    /// any
    /// data.
    sectional_elements: []const aws.map.MapEntry(SectionalElement),

    /// Stores the configuration for the form's style.
    style: FormStyle,

    /// One or more key-value pairs to use when tagging the form.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .cta = "cta",
        .data_type = "dataType",
        .environment_name = "environmentName",
        .fields = "fields",
        .form_action_type = "formActionType",
        .id = "id",
        .label_decorator = "labelDecorator",
        .name = "name",
        .schema_version = "schemaVersion",
        .sectional_elements = "sectionalElements",
        .style = "style",
        .tags = "tags",
    };
};
