const ApplyMethod = @import("apply_method.zig").ApplyMethod;

/// This data type is used as a request parameter in the
/// `ModifyDBParameterGroup` and `ResetDBParameterGroup` actions.
///
/// This data type is used as a response element in the
/// `DescribeEngineDefaultParameters` and `DescribeDBParameters` actions.
pub const Parameter = struct {
    /// Specifies the valid range of values for the parameter.
    allowed_values: ?[]const u8,

    /// Indicates when to apply parameter updates.
    apply_method: ?ApplyMethod,

    /// Specifies the engine specific parameters type.
    apply_type: ?[]const u8,

    /// Specifies the valid data type for the parameter.
    data_type: ?[]const u8,

    /// Provides a description of the parameter.
    description: ?[]const u8,

    /// Indicates whether (`true`) or not (`false`) the parameter can be modified.
    /// Some parameters have security or operational implications that prevent them
    /// from being changed.
    is_modifiable: ?bool,

    /// The earliest engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8,

    /// The name of the parameter.
    parameter_name: ?[]const u8,

    /// The value of the parameter.
    parameter_value: ?[]const u8,

    /// The source of the parameter value.
    source: ?[]const u8,

    /// The valid DB engine modes.
    supported_engine_modes: ?[]const []const u8,
};
