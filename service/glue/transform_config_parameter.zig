const ParamType = @import("param_type.zig").ParamType;

/// Specifies the parameters in the config file of the dynamic transform.
pub const TransformConfigParameter = struct {
    /// Specifies whether the parameter is optional or not in the config file of the
    /// dynamic transform.
    is_optional: ?bool = null,

    /// Specifies the list type of the parameter in the config file of the dynamic
    /// transform.
    list_type: ?ParamType = null,

    /// Specifies the name of the parameter in the config file of the dynamic
    /// transform.
    name: []const u8,

    /// Specifies the parameter type in the config file of the dynamic transform.
    @"type": ParamType,

    /// Specifies the validation message in the config file of the dynamic
    /// transform.
    validation_message: ?[]const u8 = null,

    /// Specifies the validation rule in the config file of the dynamic transform.
    validation_rule: ?[]const u8 = null,

    /// Specifies the value of the parameter in the config file of the dynamic
    /// transform.
    value: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .is_optional = "IsOptional",
        .list_type = "ListType",
        .name = "Name",
        .@"type" = "Type",
        .validation_message = "ValidationMessage",
        .validation_rule = "ValidationRule",
        .value = "Value",
    };
};
