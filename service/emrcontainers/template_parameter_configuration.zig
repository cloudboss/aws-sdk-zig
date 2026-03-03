const TemplateParameterDataType = @import("template_parameter_data_type.zig").TemplateParameterDataType;

/// The configuration of a job template parameter.
pub const TemplateParameterConfiguration = struct {
    /// The default value for the job template parameter.
    default_value: ?[]const u8 = null,

    /// The type of the job template parameter. Allowed values are: ‘STRING’,
    /// ‘NUMBER’.
    @"type": ?TemplateParameterDataType = null,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .@"type" = "type",
    };
};
