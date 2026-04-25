const TemplateVariableSource = @import("template_variable_source.zig").TemplateVariableSource;
const TemplateVariableType = @import("template_variable_type.zig").TemplateVariableType;

/// Contains metadata about a template variable.
pub const TemplateVariableMetadata = struct {
    /// The default value for the variable.
    default_value: ?[]const u8 = null,

    /// A description of the variable.
    description: ?[]const u8 = null,

    /// The maximum length for string variables.
    max_length: ?i32 = null,

    /// The maximum value for numeric variables.
    max_value: ?i32 = null,

    /// The minimum value for numeric variables.
    min_value: ?i32 = null,

    /// The regex pattern the variable value must match.
    pattern: ?[]const u8 = null,

    /// Whether the variable is required.
    required: bool = false,

    /// A sample value for the variable.
    sample: ?[]const u8 = null,

    /// The source of the variable, either `CUSTOMER` or `SYSTEM`.
    source: ?TemplateVariableSource = null,

    /// The type of the variable.
    @"type": TemplateVariableType,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .description = "Description",
        .max_length = "MaxLength",
        .max_value = "MaxValue",
        .min_value = "MinValue",
        .pattern = "Pattern",
        .required = "Required",
        .sample = "Sample",
        .source = "Source",
        .@"type" = "Type",
    };
};
