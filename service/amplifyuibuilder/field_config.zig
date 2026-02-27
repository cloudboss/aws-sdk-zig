const FieldInputConfig = @import("field_input_config.zig").FieldInputConfig;
const FieldPosition = @import("field_position.zig").FieldPosition;
const FieldValidationConfiguration = @import("field_validation_configuration.zig").FieldValidationConfiguration;

/// Describes the configuration information for a field in a table.
pub const FieldConfig = struct {
    /// Specifies whether to hide a field.
    excluded: ?bool,

    /// Describes the configuration for the default input value to display for a
    /// field.
    input_type: ?FieldInputConfig,

    /// The label for the field.
    label: ?[]const u8,

    /// Specifies the field position.
    position: ?FieldPosition,

    /// The validations to perform on the value in the field.
    validations: ?[]const FieldValidationConfiguration,

    pub const json_field_names = .{
        .excluded = "excluded",
        .input_type = "inputType",
        .label = "label",
        .position = "position",
        .validations = "validations",
    };
};
