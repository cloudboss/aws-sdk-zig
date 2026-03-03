const FileUploaderFieldConfig = @import("file_uploader_field_config.zig").FileUploaderFieldConfig;
const ValueMappings = @import("value_mappings.zig").ValueMappings;

/// Describes the configuration for the default input values to display for a
/// field.
pub const FieldInputConfig = struct {
    /// Specifies whether a field has a default value.
    default_checked: ?bool = null,

    /// The default country code for a phone number.
    default_country_code: ?[]const u8 = null,

    /// The default value for the field.
    default_value: ?[]const u8 = null,

    /// The text to display to describe the field.
    descriptive_text: ?[]const u8 = null,

    /// The configuration for the file uploader field.
    file_uploader_config: ?FileUploaderFieldConfig = null,

    /// Specifies whether to render the field as an array. This property is ignored
    /// if the
    /// `dataSourceType` for the form is a Data Store.
    is_array: ?bool = null,

    /// The maximum value to display for the field.
    max_value: ?f32 = null,

    /// The minimum value to display for the field.
    min_value: ?f32 = null,

    /// The name of the field.
    name: ?[]const u8 = null,

    /// The text to display as a placeholder for the field.
    placeholder: ?[]const u8 = null,

    /// Specifies a read only field.
    read_only: ?bool = null,

    /// Specifies a field that requires input.
    required: ?bool = null,

    /// The stepping increment for a numeric value in a field.
    step: ?f32 = null,

    /// The input type for the field.
    @"type": []const u8,

    /// The value for the field.
    value: ?[]const u8 = null,

    /// The information to use to customize the input fields with data at runtime.
    value_mappings: ?ValueMappings = null,

    pub const json_field_names = .{
        .default_checked = "defaultChecked",
        .default_country_code = "defaultCountryCode",
        .default_value = "defaultValue",
        .descriptive_text = "descriptiveText",
        .file_uploader_config = "fileUploaderConfig",
        .is_array = "isArray",
        .max_value = "maxValue",
        .min_value = "minValue",
        .name = "name",
        .placeholder = "placeholder",
        .read_only = "readOnly",
        .required = "required",
        .step = "step",
        .@"type" = "type",
        .value = "value",
        .value_mappings = "valueMappings",
    };
};
