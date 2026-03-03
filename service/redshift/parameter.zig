const ParameterApplyType = @import("parameter_apply_type.zig").ParameterApplyType;

/// Describes a parameter in a cluster parameter group.
pub const Parameter = struct {
    /// The valid range of values for the parameter.
    allowed_values: ?[]const u8 = null,

    /// Specifies how to apply the WLM configuration parameter. Some properties can
    /// be
    /// applied dynamically, while other properties require that any associated
    /// clusters be
    /// rebooted for the configuration changes to be applied.
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    apply_type: ?ParameterApplyType = null,

    /// The data type of the parameter.
    data_type: ?[]const u8 = null,

    /// A description of the parameter.
    description: ?[]const u8 = null,

    /// If `true`, the parameter can be modified. Some parameters have security
    /// or operational implications that prevent them from being changed.
    is_modifiable: ?bool = null,

    /// The earliest engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8 = null,

    /// The name of the parameter.
    parameter_name: ?[]const u8 = null,

    /// The value of the parameter. If `ParameterName` is `wlm_json_configuration`,
    /// then the maximum size of `ParameterValue` is 8000 characters.
    parameter_value: ?[]const u8 = null,

    /// The source of the parameter value, such as "engine-default" or "user".
    source: ?[]const u8 = null,
};
