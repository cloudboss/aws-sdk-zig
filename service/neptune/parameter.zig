const ApplyMethod = @import("apply_method.zig").ApplyMethod;

/// Specifies a parameter.
pub const Parameter = struct {
    /// Specifies the valid range of values for the parameter.
    allowed_values: ?[]const u8 = null,

    /// Indicates when to apply parameter updates.
    apply_method: ?ApplyMethod = null,

    /// Specifies the engine specific parameters type.
    apply_type: ?[]const u8 = null,

    /// Specifies the valid data type for the parameter.
    data_type: ?[]const u8 = null,

    /// Provides a description of the parameter.
    description: ?[]const u8 = null,

    /// Indicates whether (`true`) or not (`false`) the parameter can be
    /// modified. Some parameters have security or operational implications that
    /// prevent them from
    /// being changed.
    is_modifiable: ?bool = null,

    /// The earliest engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8 = null,

    /// Specifies the name of the parameter.
    parameter_name: ?[]const u8 = null,

    /// Specifies the value of the parameter.
    parameter_value: ?[]const u8 = null,

    /// Indicates the source of the parameter value.
    source: ?[]const u8 = null,
};
