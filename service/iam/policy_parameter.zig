const PolicyParameterTypeEnum = @import("policy_parameter_type_enum.zig").PolicyParameterTypeEnum;

/// Contains information about a policy parameter used to customize delegated
/// permissions.
pub const PolicyParameter = struct {
    /// The name of the policy parameter.
    name: ?[]const u8,

    /// The data type of the policy parameter value.
    @"type": ?PolicyParameterTypeEnum,

    /// The allowed values for the policy parameter.
    values: ?[]const []const u8,
};
