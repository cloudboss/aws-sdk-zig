const SsmParameterStoreParameterType = @import("ssm_parameter_store_parameter_type.zig").SsmParameterStoreParameterType;

/// AWS Systems Manager Parameter Store parameter.
pub const SsmParameterStoreParameter = struct {
    /// AWS Systems Manager Parameter Store parameter name.
    parameter_name: []const u8,

    /// AWS Systems Manager Parameter Store parameter type.
    parameter_type: SsmParameterStoreParameterType,

    pub const json_field_names = .{
        .parameter_name = "parameterName",
        .parameter_type = "parameterType",
    };
};
